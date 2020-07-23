local item = require 'types.item'
local function require_item(file)
	require(file)
    local name = file:match '.+%.(.*)$' or file
	if not name then
		print('解析失败', file)
		return
	end
	local skill = rawget(ac.skill, name)
	if not skill then
		print('物品技能没找到', file)
		return
	end
	local item_type = skill.item_type .. skill.level
	item.add_list(item_type, name)
end

require_item '传送test物品'
require_item '超强的物品'