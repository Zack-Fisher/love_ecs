-- definition for a level.
-- a level is a collection of entities.
local e = require("entity")
local p = require("prefab")

local one = {}

function one.load()
    -- entity constructor.
    -- the e.new() constructor can take a table array of strings, which are
    -- the groups the entity will be added to.
    -- by default, all entities are added to a "level" group.
    local ent = e.new()
    e.append(ent, "gravity", 20.0)

    -- prefabs are just functions that spawn entities.
    -- it's shorthand for the above syntax.
    p.NPC("assets/images/resa.png")
    p.fallingRockSpawner({x = 200, y = 10}, 64, 20, 20, 0.5)
end

return one