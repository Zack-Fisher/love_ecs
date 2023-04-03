local table = require("libs.table")

local Timer = {}

Timer.instances = {}

-- this is a timer that counts down to zero when the is_counting flag is true.
function Timer.new(ent, start_time)
    start_time = start_time or 1.0

    local inst = {
        is_counting = false,
        start_time = start_time,
        time_count = start_time,
    }

    Timer.instances[ent] = inst

    Timer.load(ent, inst)

    return inst
end

function Timer.load(ent, class_obj)

end

function Timer.start(obj)
    obj.time_count = obj.start_time
    obj.is_counting = true
end

function Timer.resume(obj)
    obj.is_counting = true
end

function Timer.pause(obj)
    obj.is_counting = false
end

return Timer
