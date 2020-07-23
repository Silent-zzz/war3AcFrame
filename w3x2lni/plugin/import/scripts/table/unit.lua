return {
    ["大魔法师"] = {
        id = 'Hamg',
        attribute = {
            ['生命上限'] = 4000,
            ['魔法上限'] = 5000,
            ['护甲'] = 100,
            ['攻击'] = 10,
            ['攻击范围'] = 650,
            ['移动速度'] = 325,
        },
        weapon = {
            ['弹道模型'] = [[Abilities\Weapons\RedDragonBreath\RedDragonMissile.mdl]],
            ['弹道速度'] = 900,
        },
        ['经验'] = 2000,
        ['金钱'] = 500,
        type = '英雄',
        hero_skill = {"test技能","test技能1"}
    },
    ["商店A"] = {
        id = 'n003',
        attribute = {
            ['生命上限'] = 4000,
        },
        type = '建筑',
        restriction = {'无敌', '定身'}
    },
    ["商店B"] = {
        id = 'n003',
        attribute = {
            ['生命上限'] = 4000,
        },
        type = '建筑',
        restriction = {'无敌', '定身'}
    }
}