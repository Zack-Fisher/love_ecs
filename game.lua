local Game = {}

local one = require("game.one")

local entity = require("entity")

Game.levels = {one = one}

function Game.load_level(level_name)
    for k, v in pairs(Game.levels) do
        if k == level_name then
            entity.remove_group("level")
            v.load()
            return
        end
    end

    print("could not find/load level at level_name: " .. level_name)
end

return Game
