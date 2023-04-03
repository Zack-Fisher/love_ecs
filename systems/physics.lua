local SPhysics = {}

local entity = require("entity")

function SPhysics.gravityUpdate(dt)
    local query = entity.comp_query({gravity = 0, aabb = 0})

    for ent, ent_q in pairs(query) do
        local gravity = ent_q.gravity
        local aabb = ent_q.aabb

        aabb.y = aabb.y + gravity.magnitude * dt
    end
end

return SPhysics
