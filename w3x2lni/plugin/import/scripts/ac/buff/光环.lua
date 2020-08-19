-- local copy = table.copy
local copy = function (old)
	local new = {}
	for k,v in pairs(old) do
		new[k] = v
	end
	return new
end
local ac_unit = ac.unit
local mt = ac.buff['光环']

mt.aura_pulse = 0.5

mt.model = false

mt.ref = 'origin'

mt.buff_name = ''

mt.buff_data = {}

mt.condition_function = nil

-- 光环添加时的回调
mt.add_function = nil

-- 光环移除时的回调
mt.remove_function = nil

-- 以固定点为中心施加光环
mt.search_point = nil

mt.radius = 500

-- 光环每次间隔时的回调 返回 true 则刷新全部 buff
mt.aura_function = nil

-- 离开光环后目标 buff 残留时间
mt.buff_time = false

mt.cover_type = 1

-- 默认英雄死亡时保持
mt.keep = true

-- 施法者是否有目标特效模型
mt.have_target_buff_model = false

mt.cycle_when_add = false

function mt:on_init()
	-- 目标 buff 的源光环
	self.buff_data.source_aura_buff = self
	if ac.buff[self.buff_name].cover_type == 0 then
		log.error('光环子 buff cover_type 不可叠', self.buff_name)
	end
end

local illusion_disable_skill = {

}
	
-- buff 被添加
function mt:on_add()
	local hero = self.source
	local target = self.target
	if self.model then
		if self.search_point then
			self.eff = self.search_point:add_effect({
				model = self.model,
				skip_death = self.eff_skip_death,
			})
		else
			self.eff = target:add_effect(self.ref, self.model)
		end
	end
	if hero:is_illusion() then
		local skill = self.buff_data.skill
		if skill then
			-- 如果幻象有以上光环则不会产生光环的实际效果只会有特效
			if illusion_disable_skill[skill.name] then
				return
			end
		end
	end
	local aura_pulse = self.aura_pulse * 1000
	self.aura_node = {}
	if self.selector then
		self.selector:add_filter(function(u)
			return u:get_owner() ~= ac.player[16]
		end)
	end
	if self.add_function then
		self.add_function(self)
	end
	self.aura_timer = ac.loop(aura_pulse, function()
		if self.aura_function and self.aura_function(self) then
			self:remove_all()
		end
		local update = {}
		local delete = {}
		if self.selector then
			for _, u in self.selector:ipairs() do
				update[u.handle] = true
			end
		else
            local point = self.search_point or target
            for _, u in ac.selector()
            :in_range(point, self.radius)
            :add_filter(function (u)
                if u:get_owner() == ac.player(16) then
                    return false
                end
                if self.condition_function then
                    if not self:condition_function(u) then
                        return false
                    end
                end
                return true
            end)
            :ipairs()
			do
                update[u.handle] = true
            end
		end
		for u_handle in pairs(self.aura_node) do
			if not update[u_handle] then
				delete[#delete + 1] = u_handle
			end
		end
		-- 移除不再范围的单位
		for i = 1, #delete do
			self:target_remove(delete[i])
		end
		-- 加入范围的单位
		for u_handle in pairs(update) do
			self:target_add(u_handle)
		end
	end)
	if self.cycle_when_add then
		self.aura_timer:on_timer()
	end
end

function mt:target_add(u_handle)
	local unit = ac_unit(u_handle)
	local bff = self.aura_node[u_handle]
	-- 目标根本没有buff
	-- 目标曾经被加入过，但是已经被移除（由于死亡的移除、驱散等）
	if not bff or bff.removed then
		local buff_data = copy(self.buff_data)
		-- 施法者的光环不会有目标特效模型
		if not self.have_target_buff_model and unit == self.source then
			buff_data.model = ''
		end
		self.aura_node[u_handle] = unit:add_buff(self.buff_name)(buff_data)
	-- 目标曾经被加入过，但是仍在延迟移除阶段
	elseif bff:get_remaining() ~= 0 then
		bff.timer:remove()
		bff.time = -1
	end
end

function mt:target_remove(u_handle)
	if self.buff_time then
		local buff = self.aura_node[u_handle]
		-- 已经被移除的buff排泄
		if buff.removed then
			self.aura_node[u_handle] = nil
			return
		end
		-- 处于正在延迟移除阶段的 buff 不重复受移除系统的影响
		if buff:get_remaining() ~= 0 then
			return
		end
		buff:set_remaining(self.buff_time)
	else
		self.aura_node[u_handle]:remove()
		self.aura_node[u_handle] = nil
	end
end

function mt:remove_all()
	for u_handle in pairs(self.aura_node) do
		self:target_remove(u_handle)
	end
end

function mt:on_remove()
	if self.aura_timer then
		self.aura_timer:remove()
		self:remove_all()
	end
	if self.eff then
		self.eff:remove()
	end
	-- 光环移除时的回调
	if self.remove_function then
		self.remove_function(self)
	end
end