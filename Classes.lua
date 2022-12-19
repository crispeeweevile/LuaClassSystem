local config = require("Config")
local Global = config["LoadGlobal"]
local cs = require("ClassMain")(config)

if Global then
    local dc = require("deepcopy")(config)

    _G.class = cs
    _G.deepcopy = dc
else
    return cs
end
