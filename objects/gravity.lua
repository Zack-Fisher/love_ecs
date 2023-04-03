local table = require("libs.table")

local Gravity = {}

Gravity.instances = {}

function Gravity.new(ent, magnitude)
    magnitude = magnitude or 20

    local inst = {
        magnitude = magnitude,
    }

    Gravity.instances[ent] = inst

    Gravity.load(ent, inst)

    return inst
end

function Gravity.load(ent, class_obj)

end

return Gravity
