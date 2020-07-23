ac.skill["传送test物品"]{
    item_type = "武器",
    tip = "物品说明",
    level = 1,
    gold = 100,
    art = [[ReplaceableTextures\CommandButtons\BTNPackBeast.blp]],
    affixs = {
        life = 1000,
        attack = 100,
        mana = 10,
    },
    on_add = function (self,owner)

        print("传送！")
        local item = self.parent_skill or self
        -- local owner = self.parent_skill.owner
        -- self:remove()
        -- item:remove()
        owner:blink(ac.point(0,700),true)
        
        -- ac.wait(3,function ()
            owner:add_buff '晕眩' {
                time = 5,
            }
        -- end)
        
        
    end
}
