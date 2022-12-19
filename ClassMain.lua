local objects = {}

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


                function on_call(self, ...)
                    local args = { ... }

                    local on_oc = rawget(self, "__call__")
                    if on_oc then
                        on_oc(table.unpack(args))
                    elseif self["new"] then
                        return self["new"](self, table.unpack(args))
                    else
                        error("Cannot create object for ABC")
                    end
                end

                rawset(meta, "__call", on_call)
                return newC
            elseif #args == 1 then
                local meta = {}
                local newC = setmetatable({}, meta)
                for _, __ in next, args[1] do
                    newC[_] = deepcopy(__)
                end
                function on_call(self, ...)
                    local args = { ... }

                    local on_oc = rawget(self, "__call__")
                    if on_oc then
                        on_oc(table.unpack(args))
                    elseif self["new"] then
                        return self["new"](self, table.unpack(args))
                    else
                        error("Cannot create object for ABC")
                    end
                end

                rawset(meta, "__call", on_call)
                return newC
            elseif #args > 2 then
                error("Class can only have 1 set of base data and 1 set of data to inherit")
            else
                error("Cannot make empty class")
            end
        end,
        __index = function(self, k)
            if type(k) == "string" then
                local firstTwo = string.sub(k, 1, 2)
                local lastTwo = string.sub(k, #k - 2, #k)
                assert((firstTwo == "__") and (lastTwo == "__"), "Cannot index dunder methods")
            end
            return rawget(self, k)
        end,
        __newindex = function(self, k, v)
            error("Attempt to change read-only table")
            return nil
        end
    }
    -- class_meta.__index = class_meta
    ABS = {}
    function ABS:new()
        assert(self == ABS, "Cannot instantiate ABS")
        local new = setmetatable(deepcopy(self), getmetatable(self))
        return new
    end

    local ccs = { ABS = ABS }
    setmetatable(ccs, class_meta)

    if config["LoadClassMainGlobal"] then
        _G.class = ccs
    else
        return ccs
    end
end
