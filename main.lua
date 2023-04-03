-- this runs in order, like an interpreter.
-- set globals at the top of the script.
-- basically adding this dir to our lua PATH variable. ".." is concat.
-- specified from the root of the module, not the whole OS filesystem.
-- i removed it, but package.path is the PATH of the packages in the system.
-- in a require(), we can use an absolute or relative path.

local system = require("system")
local game = require("game")
local ui = require("game.ui")
local table_lib = require("libs.table")

function love.load()
    love.window.setTitle("REREREVESSEL 0.1")
    love.window.setMode(320, 240)

    -- Set the draw color to red
    love.graphics.setColor(1, 1, 1)

    -- Set the font size to 24
    local font = love.graphics.newFont(24)
    love.graphics.setFont(font)

    system.load()
    game.load_level("one")
    ui.load()
end

function love.update(dt)
    system.update(dt)
end

function love.draw()
    system.draw()
end
