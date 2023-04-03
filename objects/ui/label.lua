local Label = {}

Label.instances = {}

-- grab position in system from aabb
-- aabb is implied here.
function Label.new(ent, text, fontSize, r, g, b)
    r = r or 1
    g = g or 1
    b = b or 1

    local inst = {
        text = text,
        font = love.graphics.newFont(24),
        r = r,
        g = g,
        b = b,
    }

    Label.instances[ent] = inst

    Label.load(ent, inst)

    return inst
end

function Label.load(ent, inst)

end

return Label