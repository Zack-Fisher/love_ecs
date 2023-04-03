local table = require("libs.table")

local Sprite = {}

Sprite.instances = {}

function Sprite.new(ent, image_path)
    local inst = {
        image_path = image_path,
    }

    Sprite.instances[ent] = inst

    Sprite.load(ent, inst)

    return inst
end

function Sprite.load(ent, class_obj)
    print("adding sprite component")
    print(table.dump(class_obj), " at entity id: " .. ent)
end

return Sprite
