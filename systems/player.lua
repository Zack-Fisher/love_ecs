local SPlayer = {}
local entity = require("entity")

function SPlayer.playerUpdate(dt)
    local query = entity.comp_query({player = 0, aabb = 0, character = 0})

    for ent, ent_q in pairs(query) do
        local player = ent_q.player
        local aabb = ent_q.aabb
        local character = ent_q.character

        local dx, dy = 0, 0

        local c = require("objects.character")
        if love.keyboard.isDown("left") then
            dx = dx - 1
            character.direction = c.directions.left
        end
        if love.keyboard.isDown("right") then
            dx = dx + 1
            character.direction = c.directions.right
        end
        if love.keyboard.isDown("up") then
            dy = dy - 1
            character.direction = c.directions.up
        end
        if love.keyboard.isDown("down") then
            dy = dy + 1
            character.direction = c.directions.down
        end

        -- Move the AABB based on the arrow key inputs
        aabb.x = aabb.x + dx * player.speed * dt
        aabb.y = aabb.y + dy * player.speed * dt

        if math.abs(dx) > 0 or math.abs(dy) > 0 then
            character.is_moving = true
        else
            character.is_moving = false
        end
    end
end

function SPlayer.respawn()
    local query = entity.comp_query({player = 0})

    if #query <= 0 then
        require("game.levelManager").respawn_player()
    end
end

return SPlayer