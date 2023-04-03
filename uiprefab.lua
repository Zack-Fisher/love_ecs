-- a bunch of helper methods that spawn predefined entity bundles with specific components.
local e = require("entity")

local UIPrefab = {}

function UIPrefab.textbox(x, y, text, fontsize, r, g, b)
    local ent = e.new()
    e.append(ent, "label", text, fontsize, r, g, b)
    -- width and height here don't really matter right now.
    e.append(ent, "aabb", x, y, 50, 50)
end

return UIPrefab
