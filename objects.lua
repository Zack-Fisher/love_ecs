local aabb = require("objects.aabb")
local player = require("objects.player")
local gravity = require("objects.gravity")
local sprite = require("objects.sprite")
local character = require("objects.character")
local characterSprite = require("objects.characterSprite")
local damageBox = require("objects.damageBox")
local health = require("objects.health")
local label = require("objects.ui.label")
local timer = require("objects.timer")
local spawner = require("objects.spawner")

-- there's already a "table" lua stdlib
local table_lib = require("libs.table")

local Objects = {}

-- use these key-value pairs to automate component query logic.
-- the keys are the same keys that we use in the query nametables.
-- YES. THIS IS EXACTLY WHAT I WANTED IN C++.
-- LET'S GO.
Objects.components = {}

Objects.components.aabb = aabb
Objects.components.sprite = sprite
Objects.components.player = player
Objects.components.gravity = gravity
Objects.components.character = character
Objects.components.characterSprite = characterSprite
Objects.components.damageBox = damageBox
Objects.components.health = health
Objects.components.label = label
Objects.components.spawner = spawner
Objects.components.timer = timer

--NOTE: objects can "load" themselves in the constructor.

-- THE KEY ASSUMPTION IS THAT ALL COMP TABLES USE THE "instances" NAME.
-- these are defs for general systems that run over each component type.
-- each comp has one system of each type, and we can use flexible function types to
-- build off of each system condition.
-- it's like an ecs lite. it doesn't quite have the same thing as associating systems
-- with comps directly (like in unity or something), but this is appropriate i think

-- removes all of the components associated with an entity.
function Objects.remove_ent(ent)
    for _, comp in ipairs(Objects.components) do
        comp.instances[ent] = nil
    end
end

return Objects