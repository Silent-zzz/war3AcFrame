ac.skill["超强的物品"]{
    item_type = "武器",
    tip = "物品说明",
    level = 1,
    gold = 100,
    art = [[ReplaceableTextures\CommandButtons\BTNReplay-SpeedUp.blp]],
    affixs = {
        life = 1000,
        attack = 100,
        mana = 10,
    },
    on_add = function (self)
        -- print(self.parent_skill)
        local owner = self.parent_skill.owner
        ac.wait(3,function ()
            owner:add_buff '眩晕' {
                time = 5,
            }
        end)
        
        -- for key, value in pairs(self.parent_skill) do
        -- 	print(key,value)
        -- end
        -- print("单位获得了",self)
        
    end
}