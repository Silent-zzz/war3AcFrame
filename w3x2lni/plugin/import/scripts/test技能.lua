local dxt = ac.skill["test技能"]({
    --初始等级
    level = 1,
    --最大等级
    max_level = 1,
    --英雄需要的等级
    requirement = {1},
    --图标
    art = [[ReplaceableTextures\CommandButtons\BTNPackBeast.blp]],
    --技能名字
    title = [[这是技能的名字]],
    --技能说明
    tip = [[这是技能的说明]],
    --技能消耗
    cost = 1,
    --技能cd
    cool = 1,
    --施法范围
    range = 500,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_UNIT_OR_POINT,
    -- --施法时间
    -- cast_start_time = 1,
    -- cast_shot_time = 0.3,
    --动画
    cast_animation = 10,
    cast_animation_speed = 0.6,
    -- passive = true,
    --热键，
    hotkey = "Q"
})
function dxt:on_cast_channel() 
    local point = self.target:get_point() or self.target
    local source = self.owner
    source:add_skill("传送test物品","物品")
    for _, u in ac.selector()
                :in_range(point,300)
                :is_enemy(source)
                :ipairs() do
        u:damage {
            source = source,
            skill = self,
            damage = 1000,
        }
    end
end

local dxt = ac.skill["test技能1"]({
    --初始等级
    level = 1,
    --最大等级
    max_level = 1,
    --英雄需要的等级
    requirement = {1},
    --图标
    art = [[ReplaceableTextures\CommandButtons\BTNPackBeast.blp]],
    --技能名字
    title = [[这是技能的名字]],
    --技能说明
    tip = [[这是技能的说明]],
    --技能消耗
    cost = 1,
    --技能cd
    cool = 1,
    --施法范围
    range = 500,
    passive = true,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_UNIT_OR_POINT,
    -- --施法时间
    -- cast_start_time = 1,
    -- cast_shot_time = 0.3,
    --动画
    cast_animation = 10,
    cast_animation_speed = 0.6,
    --热键，
    hotkey = "W"
})
function dxt:on_cast_channel() 
    local point = self.target:get_point() or self.target
    local source = self.owner
    source:add_skill("传送test物品","物品")
    for _, u in ac.selector()
                :in_range(point,300)
                :is_enemy(source)
                :ipairs() do
        
        u:damage {
            source = source,
            skill = self,
            damage = 1000,
        }
    end
end