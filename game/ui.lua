-- write the layout of the UI here, from the components and prefabs we already have.
local e = require("entity")
local p = require("uiprefab")

local UI = {}

function UI.load()
    p.textbox(30, 30, "welcome to REREREVESSEL.", 24, 0.8, 0.8, 0.1)
end

return UI