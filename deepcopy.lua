return function(config)
    if _G["deepcopy"] then return end
    local function deepcopy(orig) --We need this to copy a table entirely while preventing just cloning the address of a table
        local orig_type = type(orig)
        local copy
        if orig_type == 'table' then
            copy = {}
            for orig_key, orig_value in next, orig, nil do
                if orig == orig_value then copy[deepcopy(orig_key)] = copy end
                copy[deepcopy(orig_key)] = deepcopy(orig_value)
            end
            setmetatable(copy, deepcopy(getmetatable(orig)))
            --if getmetatable(copy) ~= nil then
            --	getmetatable(copy).__index = getmetatable(copy)
            --end
        else
            copy = orig
        end

        return copy
    end --crispeeweevile did NOT make this function. It was found online
    
    if config["LoadDeepcopyGlobal"] then
        _G.deepcopy = deepcopy
    else
        return deepcopy
    end
end
