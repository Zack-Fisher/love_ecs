local table = require("libs.table")

local Health = {}

Health.instances = {}

function Health.new(ent, max_health)
    max_health = max_health or 200

    local inst = {
        health = max_health,
        max_health = max_health,
    }

    Health.instances[ent] = inst

    Health.load(ent, inst)

    return inst
end

function Health.load(ent, class_obj)

end

return Health
