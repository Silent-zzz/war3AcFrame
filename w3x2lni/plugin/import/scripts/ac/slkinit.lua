
local a = {
    ac=1,
    ab={a=2},
    bb=333,
}
b= next(a)
print(type(b))
print(a[b])

local t = {
    ss = {}
}
for key, value in pairs(t) do
    print("t",key,value)
end
