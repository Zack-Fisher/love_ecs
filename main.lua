local system = require("system")
local game = require("game")
local ui = require("game.ui")
local table_lib = require("libs.table")

function love.load()
    love.window.setMode(320, 240)

    -- Set the draw color to red
    love.graphics.setColor(1, 1, 1)

    -- Set the font size to 24
    local font = love.graphics.newFont(24)
    love.graphics.setFont(font)

    -- system as in ECS Systems. this runs all the startup systems specified in the system.lua module.
    system.load()

    -- loads a bundle of prefabs and entities based on the level data.
    game.load_level(game.levels.one)

    ui.load()
end

function love.update(dt)
    -- runs all the update systems each frame
    system.update(dt)
end

function love.draw()
    -- runs all the drawing systems each frame.
    system.draw()
end
