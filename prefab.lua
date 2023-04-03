-- a bunch of helper methods that spawn predefined entity bundles with specific components.
local e = require("entity")

local Prefab = {}

function Prefab.player()
    local ent = e.new()
    e.append(ent, "characterSprite", "assets/images/resa.png")
    e.append(ent, "health")
    e.append(ent, "player", 200)
    e.append(ent, "character")
    e.append(ent, "aabb", 40, 40, 32, 48)
end

function Prefab.NPC(tileset_path)
    local ent = e.new()
    e.append(ent, "characterSprite", tileset_path)
    e.append(ent, "health")
    e.append(ent, "character")
    e.append(ent, "aabb", 200, 80, 32, 48)
end

-- position is a table with .x and .y params.
function Prefab.fallingRock(position, size, damage, speed)
    -- lua default params pattern
    position = position or {x = 500, y = 0}
    size = size or 64
    damage = damage or 10

    local ent = e.new()
    e.append(ent, "gravity", speed)
    e.append(ent, "sprite", "assets/images/boulder.png")
    e.append(ent, "aabb", position.x, position.y, size, size)
    e.append(ent, "damageBox", damage)
end

function Prefab.fallingRockSpawner(position, size, damage, rock_speed, cooldown)
    local ent = e.new()
    local spawner_aabb = e.append(ent, "aabb", position.x, position.y, size, size)
    e.append(ent, "spawner", Prefab.fallingRock, {x = spawner_aabb.x, y = spawner_aabb.y}, size, damage, rock_speed)
    e.append(ent, "timer", cooldown)
end

return Prefab
