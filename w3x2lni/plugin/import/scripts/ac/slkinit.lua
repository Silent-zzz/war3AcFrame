
-- local a = {
--     ac=1,
--     ab={a=2},
--     bb=333,
-- }
-- b= next(a)
-- print(type(b))
-- print(a[b])

-- local t = {
--     ss = {}
-- }

-- for key, value in pairs(t) do
--     print("t",key,value)
-- end
local s = "这是第一个参数%s这是第二个参数%f"
print(s:format("1",2.5))
local s = -5
print(tonumber(s))