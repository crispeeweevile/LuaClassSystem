return function(config)
    if _G["class"] then return end
    local deepcopy = require("deepcopy")(config)

    local class_meta = {
        __call = function(self, ...)
            local args = { ... }
            if #args == 2 then
                local meta = {}
                local newC = setmetatable(deepcopy(args[1]), meta)
                for _, __ in next, args[2] do
                    newC[_] = deepcopy(__)
                end
                rawset(meta, "__call", newC["new"])
                return newC
            elseif #args == 1 then
                local meta = {}
                local newC = setmetatable({}, meta)
                for _, __ in next, args[1] do
                    newC[_] = deepcopy(__)
                end
                rawset(meta, "__call", newC["new"])
                return newC
            elseif #args > 2 then
                error("Class can only have 1 set of base data and 1 set of data to inherit")
            else
                error("Cannot make empty class")
            end
        end,
        __index = function(self, k)
            return rawget(self, k)
        end,
        __newindex = function(self, k, v)
            error("Attempt to change read-only table")
            return nil
        end
    }
    -- class_meta.__index = class_meta
    local ccs = {}
    setmetatable(ccs, class_meta)

    if config["LoadClassMainGlobal"] then
        _G.class = ccs
    else
        return ccs
    end
end
