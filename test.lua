require("Classes")

x = class({
    new = function(self)

        local new = setmetatable(deepcopy(self), getmetatable(self))
        return new
    end,

    ["Health"] = 100,
    ["MaxHealth"] = 150
})

for index, value in next,class do
    print(index, value)
end

a = x()
b = x()