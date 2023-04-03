local table = require("libs.table")

local Spawner = {}

Spawner.instances = {}

-- intended to call a prefab func with the specified arguments every little while.
-- (when the timer has is_counting = false)
-- assuming the existence of an attached timer.
function Spawner.new(ent, prefab_func, ...)
    local inst = {
        prefab_func = prefab_func,
        args = ...,
    }

    Spawner.instances[ent] = inst

    Spawner.load(ent, inst)

    return inst
end

function Spawner.load(ent, class_obj)

end

return Spawner
