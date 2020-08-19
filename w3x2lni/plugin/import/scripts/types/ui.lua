local jass = require 'jass.common'
local dz = require 'jass.dzapi'
local jp = require 'jass.dzapi'
local ui = {}
setmetatable(ui, ui)
--加载toc文件
dz.DzLoadToc( "war3mapImported\\dxUI.toc" )

ac.ui = ui

ui.point = {
    left_top = 0;
    top = 1;
    right_top = 2;
    left = 3;
    center = 4;
    right = 5;
    left_bottom = 6;
    bottom = 7;
    right_bottom = 8;
}
--结构
local mt = {}
ui.__index = mt

--类型
mt.type = 'ui'

--句柄
mt.handle = 0

--缩放
mt.scale = 1

--宽高
mt.width = 0
mt.hight = 0

--位置
mt.x = 0
mt.y = 0

--文本
mt.text = ""

--贴图
mt.texture = ""

--透明度
mt.alpha = 255

local function ui_init(handle,name)
    local obj = setmetatable({},ui)
    obj.handle = handle
    obj.name = name or "未知"
    return obj
end

--设置相对位置
function mt:set_position(point,rela_ui,rela_p,x,y)
    x,y = x or 0 , y or 0
    rela_ui = type(rela_ui) == "table" and rela_ui or ui_init(rela_ui)
    jp.DzFrameSetPoint( self.handle, point, rela_ui.handle, rela_p, x, y )
    self.relative_ui = rela_ui
    self.point = point
    self.relative_point = rela_p
    self.x,self.y = x,y
end

--设置绝对位置
function mt:set_absposition(point,x,y)
    jp.DzFrameSetAbsolutePoint( self.handle, point, x or 0.0, y or 0.0 )
    self.x,self.y = x or 0,y or 0
end

--缩放
function mt:set_scale(size)
    jp.DzFrameSetScale(self.handle,size or 0.0001)
    self.scale = size
end

--设置大小
function mt:set_size(x,y)
    jp.DzFrameSetSize(self.handle,x or 0,y or 0)
    self.width,self.hight = x,y
end

--设置焦点
function mt:set_focus(isfocus)
    jp.DzFrameSetFocus(self.handle,isfocus and true or false)
    self.set_focus = isfocus and true or false
end

--设置文本
function mt:set_text(str)
    jp.DzFrameSetText(self.handle,str)
    self.text = str
end

--设置贴图
function mt:set_texture(path,flag)
    flag = type(flag) == "boolean" and flag and 1 or flag>0 and 1 or 0 
    jp.DzFrameSetTexture(self.handle,path,flag)
    self.texture = path
    self.texture_flag = flag
end

--设置透明度
function mt:set_alpha(alpha)
    jp.DzFrameSetAlpha(self.handle,alpha)
    self.alpha = alpha
end

--设置颜色
function mt:set_color(color)
    jp.DzFrameSetVertexColor( self.handle, jp.DzGetColor(color[1], color[2], color[3], color[4] or self.alpha) )
    self.color = {color[1], color[2], color[3]}
    self.alpha = color[4] and color[4] or self.alpha
end

--设置提示UI
function mt:set_tip(tip_ui)
    if type(tip_ui) == "table" and tip_ui.type == "ui" then
        jp.DzFrameSetTooltip( self.handle, tip_ui.handle )
    else
        jp.DzFrameSetTooltip( self.handle, tip_ui )
    end
    self.tip = tip_ui
end

--限制鼠标
function mt:set_mouse(iscage)
    iscage = iscage and true or false
    jp.DzFrameCageMouse( self.handle, iscage )
    self.is_cage = iscage
end

--设置模型
function mt:set_model(path,_type,flag)
    jp.DzFrameSetModel( self.handle, path, _type, flag )
end

--设置模型
function mt:set_model(path,_type,flag)
    jp.DzFrameSetModel( self.handle, path, _type, flag )
end

--注册ui事件
function mt:reg_code(event,code,is_sync)
    is_sync = is_sync and true or false
    jp.DzFrameSetScriptByCode( self.handle, event, code, is_sync )
    self[event] = {
        code = code;
        sync = is_sync;
    }
end

--点击ui
function mt:click()
    jp.DzClickFrame(self.handle)
end

--清空所有锚点
function mt:clear_allpoint()
    jp.DzFrameClearAllPoints(self.handle)
end

--设置最大值，最小值 (类似进度条之类的)
function mt:set_maxmin(min,max)
    jp.DzFrameSetMinMaxValue( self.handle, min, max )
    self.min = min
    self.max = max
end

--设置步进值 （只支持Slider）
function mt:set_step(step)
    jp.DzFrameSetStepValue( self.handle, step )
end

--设置当前值()
function mt:set_val(val)
    jp.DzFrameSetValue( self.handle,val )
    self.val = val
end

--设置是否禁用
function mt:set_enable(en)
    en = en and true or false
    jp.DzFrameSetEnable( self.handle, en )
    self.is_enable = en
end

--设置是否隐藏
function mt:set_show(show)
    show = show and true or false
    jp.DzFrameShow( self.handle,show )
    self.show = show
end

--设置字体
function mt:set_font(path,size,flag)
    jp.DzFrameSetFont( self.handle, path,size, flag and flag or 0 )--最后一个参数flag目前作用未知
    self.font = path
    self.font_size = size
end

--销毁ui
function mt:remove()
    jp.DzDestroyFrame( self.handle )
end
local ui_id = {}
--创建一个UI,ByTagName
function ui.create_name(fr_type, fr_name, fr_parent,template)
    fr_parent = type(fr_parent) == "table" and fr_parent or ui_init(fr_parent)
    if not ui_id[fr_name] then
        ui_id[fr_name] = -1
    end
    ui_id[fr_name] = ui_id[fr_name] + 1
    local id = ui_id[fr_name]
    local handle = jp.DzCreateFrameByTagName(fr_type, fr_name, fr_parent.handle,template,id)
    local obj = setmetatable({},ui)
    obj.handle = handle
    obj.parent = fr_parent
    obj.ui_type = fr_type
    obj.template = template
    obj.id = id
    obj.name=fr_name
    return obj
end
--创建一个UI
function ui.create(fr_name, fr_parent)
    fr_parent = type(fr_parent) == "table" and fr_parent or ui_init(fr_parent)
    if not ui_id[fr_name] then
        ui_id[fr_name] = -1
    end
    ui_id[fr_name] = ui_id[fr_name] + 1
    local id = ui_id[fr_name]
    local handle = jp.DzCreateFrame(fr_name, fr_parent.handle, id)
    local obj = setmetatable({},ui)
    obj.handle = handle
    obj.parent = fr_parent
    obj.name=fr_name
    return obj
end

function ui.init()
    --游戏UI
    ac.ui["游戏UI"] = ui_init(dz.DzGetGameUI(),"游戏UI")
    --小地图
    ac.ui["小地图"] = ui_init(dz.DzFrameGetMinimap(),"小地图")
    --人物大头像
    ac.ui["大头像"] = ui_init(dz.DzFrameGetPortrait(),"大头像")
    --技能按钮
    -- ac.ui["技能"] = {}
    local sloid = 0
    ac.ui.skill = {}
    for x = 0, 2 do
        for y = 2, 0,-1 do
            sloid = sloid + 1
            --DzFrameGetCommandBarButton(0, 0)
            ac.ui[("技能%d%d"):format(x,y)] = ui_init(dz.DzFrameGetCommandBarButton(y, x),("技能%d%d"):format(x,y))
            ac.ui.skill[sloid] = ac.ui[("技能%d%d"):format(x,y)]
        end
    end
    ac.ui.item = {}
    for i = 0, 5 do
        ac.ui[("物品%d"):format(i)] = ui_init(dz.DzFrameGetItemBarButton(i),("物品%d"):format(i))
        ac.ui.item[i+1] = ac.ui[("物品%d"):format(i)]
    end
    ac.ui["鼠标提示"] = ui_init(dz.DzFrameGetTooltip(),"鼠标提示")
end

--创建一个button模板
--原理是创建一个背景版，然后再创建一个button绑定在背景板上，来作为接收触发的空ui
function ac.ui.create_btn(fr_parent,template)
    fr_parent = type(fr_parent) == "table" and fr_parent or ui_init(fr_parent)
    if not ui_id["btn"] then
        ui_id["btn"] = -1
    end
    ui_id["btn"] = ui_id["btn"] + 1
    local id = ui_id["btn"]
    print(id)
    local btn_handle = jp.DzCreateFrameByTagName("BUTTON", "name", fr_parent.handle,template or "template",id)
    local back_handle = jp.DzCreateFrameByTagName("BACKDROP","name",btn_handle,template or "template",id)
    local obj = setmetatable({},ui)
    local backobj = setmetatable({},ui)
    obj.handle = btn_handle
    obj.parent = fr_parent
    obj.template = template or "template"
    obj.id = id
    obj.back = backobj
    backobj.handle = back_handle
    backobj.parent = obj
    backobj.template = template or "template"
    backobj.id = id
    backobj:set_position(ac.ui.point.center,obj,ac.ui.point.center,0,0)
    return obj
end

ui.init()
return ui