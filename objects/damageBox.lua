local table_lib = require("libs.table")

local DamageBox = {}

DamageBox.instances = {}

function DamageBox.new(ent, damage)
    damage = damage or 1

    local inst = {
        damage = damage
    }

    DamageBox.instances[ent] = inst

    DamageBox.load(ent, inst)

    return inst
end

function DamageBox.load(ent, class_obj)
    print("adding DamageBox component")
    print(table_lib.dump(class_obj), " at entity id: " .. ent)
end

return DamageBox