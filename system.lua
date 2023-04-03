local entity = require("entity")
local objects = require("objects")

local table_lib = require("libs.table")

local sPlayer = require("systems.player")
local sPhysics = require("systems.physics")
local sCharacter = require("systems.character")
local sUI = require("systems.ui.uisys")

-- if we bundle the logic with the components themselves, they need to query other comps
-- so we get a cyclic dep error!
-- this is a benefit of using systems that i didn't even anticipate.
local System = {}

-- for running debug prints and etc
local function testerUpdate(dt)

end

local function spriteRenderSystem()
    local query = entity.comp_query({sprite = 0, aabb = 0})

    for ent, sprite_aabb in pairs(query) do
        local sprite = love.graphics.newImage(sprite_aabb.sprite.image_path)

        local width = sprite_aabb.aabb.width
        local height = sprite_aabb.aabb.height

        -- Get the dimensions of the texture
        local texture_width = sprite:getWidth()
        local texture_height = sprite:getHeight()

        -- Calculate the scaling factors
        local scale_x = width / texture_width
        local scale_y = height / texture_height

        -- Draw the sprite at the position of the AABB instance
        love.graphics.draw(sprite, sprite_aabb.aabb.x, sprite_aabb.aabb.y, 0, scale_x, scale_y)
    end
end

local function damageBoxSystem()
    local dbox_query = entity.comp_query({damageBox = 0, aabb = 0})
    local player_query = entity.comp_query({health = 0, aabb = 0})

    local aabb = require("objects.aabb")
    for p_ent, p_ent_q in pairs(player_query) do
        for d_ent, d_ent_q in pairs(dbox_query) do
            local p_aabb = p_ent_q.aabb
            local p_health = p_ent_q.health

            local d_aabb = d_ent_q.aabb
            local d_damageBox = d_ent_q.damageBox

            if aabb.intersect(p_aabb, d_aabb) then
                p_health.health = p_health.health - d_damageBox.damage
            end
        end
    end
end

-- system that manages entity death
local function healthSystem()
    local query = entity.comp_query({health = 0})

    for ent, ent_q in pairs(query) do
        local health = ent_q.health
        if health.health < 0 then
            entity.remove(ent)
        end

        if health.health > health.max_health then
            health.health = health.max_health
        end
    end
end

-- have attachments poll the status of the flag, and restart it if necessary.
-- for multiple attachments to easily know when the timer hits zero, need some sort of 
-- event system?
local function timerSystem(dt)
    local c_timer = require("objects.timer")
    local query = entity.comp_query({timer = 0})

    for ent, ent_q in pairs(query) do
        local timer = ent_q.timer
        if timer.time_count < 0.0 then
            timer.time_count = 0.0
            
            c_timer.pause(timer)
        elseif timer.is_counting then
            timer.time_count = timer.time_count - dt
        end
    end
end

local function spawnerSystem(dt)
    local c_timer = require("objects.timer")
    local query = entity.comp_query({spawner = 0, timer = 0, aabb = 0})

    for ent, ent_q in pairs(query) do
        local spawner = ent_q.spawner
        local timer = ent_q.timer
        local aabb = ent_q.aabb

        if timer.is_counting == false then
            spawner.prefab_func(spawner.args)
            
            c_timer.start(timer)
        end
    end
end

local function drawBackground()
    love.graphics.clear(0.4, 0.0, 0.3)
end

-- prepare to add some sort of general condition framework to the systems.
-- loop over the systems at runtime.
local startup_systems = {

}

local update_systems = {
    -- game systems
    {condition = {}, system = testerUpdate},
    {condition = {}, system = sPlayer.playerUpdate},
    {condition = {}, system = sPlayer.respawn},
    {condition = {}, system = sPhysics.gravityUpdate},
    {condition = {}, system = healthSystem},
    {condition = {}, system = damageBoxSystem},
    {condition = {}, system = timerSystem},
    {condition = {}, system = spawnerSystem},

    --ui systems
}

local draw_systems = {
    --game systems
    {condition = {}, system = drawBackground},
    {condition = {}, system = spriteRenderSystem},
    {condition = {}, system = sCharacter.characterSpriteRenderSystem},
    --ui systems
    {condition = {}, system = sUI.drawText},
}

-- dummy for now.
function System.check_condition(condition)
    return true
end

function System.load()
    for _, system in ipairs(startup_systems) do
        if System.check_condition(system.condition) then
            system.system()
        end
    end
end

function System.update(dt)
    for _, system in ipairs(update_systems) do
        if System.check_condition(system.condition) then
            system.system(dt)
        end
    end
end

-- helper for System.draw()
local function refresh()
    love.graphics.setColor(1, 1, 1)
end

function System.draw()
    for _, system in ipairs(draw_systems) do
        if System.check_condition(system.condition) then
            --refresh the drawing color back to normal after each.
            refresh()

            system.system()
        end
    end
end

return System