local config = require("Config")
local Global = config["LoadGlobal"]
local cs = require("ClassMain")

if Global then
    local dc = require("deepcopy")(config)

    _G.class = cs(config)
    _G.deepcopy = dc
else
    return cs
end
