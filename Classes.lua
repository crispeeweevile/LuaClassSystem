local config = require("Config")
local Global = config["LoadGlobal"]
local cs = require("ClassMain")

if Global then
    local dc = require("deepcopy")

    _G.class = cs
    _G.deepcopy = dc
else
    return cs
end
