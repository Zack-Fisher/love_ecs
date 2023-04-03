local table_lib = require("libs.table")

local Character = {}

Character.instances = {}

Character.directions = {up = 1, right = 2, down = 3, left = 4}

function Character.new(ent, init_dir)
    print("called character constructor")
    init_dir = init_dir or Character.directions.down

    if init_dir > 4 or init_dir < 1 then
        print("you passed an invalid direction to the Character constructor. returning...")
        print("the direction: " .. init_dir)
        print("options: " .. table_lib.dump(Character.directions))
        return
    end

    -- needs a direction to render the sprite animation.
    local inst = {
        direction = init_dir,
        is_moving = false,
    }

    Character.instances[ent] = inst

    Character.load(ent, inst)

    return inst
end

function Character.load(ent, class_obj)
    print("adding Character component")
    print(table_lib.dump(class_obj), " at entity id: " .. ent)
end

return Character
