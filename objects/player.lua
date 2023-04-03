local table = require("libs.table")

local Player = {}

Player.instances = {}

function Player.new(ent, speed)
    local inst = {
        speed = speed
    }

    Player.instances[ent] = inst

    Player.load(ent, inst)

    return inst
end

function Player.load(ent, class_obj)

end

return Player
