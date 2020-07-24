local std_print = print

function print(...)
	std_print(('[%.3f]'):format(os.clock()), ...)
end

local function main()
	print 'main入口'
	--print ('package.path = ', package.path)

	require 'war3.id'
	require 'war3.api'
	require 'util.log'
	require 'ac.init'
	require 'util.error'
	local runtime = require 'jass.runtime'
	if runtime.perftrace then
		runtime.perftrace()
		ac.loop(10000, function()
			log.info('perftrace', runtime.perftrace())
		end)
	end
	
	ac.lni_loader('unit')
	-- local unit = cj.FirstOfGroup(cj.GroupEnumUnitsOfPlayer(g, cj.Player(0), nil))
	-- print(ac.unit(unit))

	local rect		= require 'types.rect'
	local circle	= require 'types.circle'
	local region	= require 'types.region'
	local effect	= require 'types.effect'
	local fogmodifier	= require 'types.fogmodifier'
	local move		= require 'types.move'
	local unit		= require 'types.unit'
	local attribute	= require 'types.attribute'
	local hero		= require 'types.hero'
	local damage	= require 'types.damage'
	local heal		= require 'types.heal'
	local mover		= require 'types.mover'
	local follow	= require 'types.follow'
	local texttag	= require 'types.texttag'
	local lightning	= require 'types.lightning'
	local path_block	= require 'types.path_block'
	local item		= require 'types.item'
	local game		= require 'types.game'
	local shop		= require 'types.shop'

	local sound		= require 'types.sound'
	local sync		= require 'types.sync'
	local response	= require 'types.response'
	--地图本身的积分
	-- local record	= require 'types.record'
	
	--初始化
	rect.init()
	damage.init()
	move.init()
	unit.init()
	hero.init()
	effect.init()
	mover.init()
	follow.init()
	lightning.init()
	texttag.init()
	shop.init()
	path_block.init()
	game.init()

	game.register_observer('hero move', move.update)
	game.register_observer('mover move', mover.move)
	game.register_observer('path_block', path_block.update)
	game.register_observer('follow move', follow.move)
	game.register_observer('lightning', lightning.update)
	game.register_observer('texttag', texttag.update)
	game.register_observer('mover hit', mover.hit)

	require 'war3.target_data'
	require 'war3.order_id'
	local page = shop.createPage '主页'
[[
	$test物品	$test物品		~		~
	$test物品		~		~		~
	$test物品		~		~		~
]]
local page = shop.createPage '第二'
[[
	$超强的物品	$test物品		~		~
	$超强的物品		~		~		~
	$test物品		~		~		~
]]
	local player = require 'ac.player'
	local cj = require 'jass.common'
	ac.game:event '玩家-聊天' (function (trg,player, chat )
		print(trg,player,chat)
		local group = cj.CreateGroup()
		cj.GroupEnumUnitsOfPlayer(group,player.handle,nil)
		player:addGold(999999)
		player:addRes("积分",99999)
		player.hero = ac.unit(cj.FirstOfGroup(group))
		-- player.hero:find_skill("test技能"):disable_ability()
		player.hero:add_skill("传送test物品","物品")
	end)
	
	-- --测试
	require 'test.init'
	-- player[1]:create_unit('n003',ac.point(0,0),0)
	local shop1 = shop.create(player[1],"商店A",ac.point(0,0),0)
	shop.create(player[1],"商店A",ac.point(0,500),0,"第二")

	--游戏
	-- local map = require 'maps.map'
	require 'test技能'
	

	ac.item.add_list("物品","test物品")

	--保存预设单位
	unit.saveDefaultUnits()
	
	-- map.init()

	--加载热补丁
	-- require 'types.hot_fix'

	--require 'test.sound'
	local jass = require 'jass.common'
	jass.SetMapFlag(8192 * 2, true)
end


main()

