-- definition for a level.
-- a level is a collection of entities.
local e = require("entity")
local p = require("prefab")
local l = require("game.levelManager")

local one = {}

function one.load()
    l.spawn_common()

    p.NPC("assets/images/resa.png")
    p.fallingRockSpawner({x = 200, y = 10}, 64, 20, 20, 0.5)
end

return one