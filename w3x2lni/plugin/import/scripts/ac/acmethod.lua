local table_insert = table.insert

local function idCreator(head)
    local chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    local index = -1
    return function ()
        index = index + 1
        local c3 = index % #chars + 1
        local c2 = index // #chars % #chars + 1
        local c1 = index // #chars // #chars % #chars + 1
        return head .. chars:sub(c1, c1) .. chars:sub(c2, c2) .. chars:sub(c3, c3)
    end
end
function ac.nextId(head)
    return idCreator(head) 
end

function ac.getNextId(id)
    local chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    local index
    for i =1,#chars do
        if id:sub(#id,#id) == chars:sub(i) then
            index = i
            break
        end
    end
    local c3 = index % #chars + 1
    local c2 = index // #chars % #chars + 1
    local c1 = index // #chars // #chars % #chars + 1
    return id
end

ac.id = setmetatable({}, {__index = function (self, id)
    if type(id) == 'string' then
        self[id] = ('>I4'):unpack(id)
    else
        self[id] = ('>I4'):pack(id)
    end
    return self[id]
end})

function ac.pop(t)
    local re = t[#t]
    t[#t] = nil
    return re
end
function ac.push(t,value)
    table_insert(t,value)
end