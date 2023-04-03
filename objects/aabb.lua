local table = require("libs.table")

local AABB = {}

AABB.instances = {}

function AABB.new(ent, x, y, width, height)
    x = x or 0
    y = y or 0

    local inst = {
        x = x,
        y = y,
        width = width,
        height = height
    }

    AABB.instances[ent] = inst

    AABB.load(ent, inst)

    return inst
end

function AABB.load(ent, class_obj)
    print("adding aabb component")
    print(table.dump(class_obj), " at entity id: " .. ent)
end

-- Check for intersection between two AABBs
function AABB.intersect(aabb1, aabb2)
    local x1, y1, w1, h1 = aabb1.x, aabb1.y, aabb1.width, aabb1.height
    local x2, y2, w2, h2 = aabb2.x, aabb2.y, aabb2.width, aabb2.height
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end

return AABB
