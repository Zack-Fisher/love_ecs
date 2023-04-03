local SUI = {}

local entity = require("entity")

function SUI.drawText()
    local query = entity.comp_query({label = 0, aabb = 0})

    for ent, ent_q in pairs(query) do
        local aabb = ent_q.aabb
        local label = ent_q.label

        love.graphics.setFont(label.font)
        love.graphics.setColor(label.r, label.g, label.b)

        love.graphics.print(label.text, aabb.x, aabb.y)
    end
end

return SUI