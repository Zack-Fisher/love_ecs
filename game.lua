local Game = {}

local one = require("game.one")

local entity = require("entity")

Game.levels = {one = one}

-- pass in a level module from Game.levels.
function Game.load_level(level_module)
    entity.remove_group("level")
    level_module.load()
end

return Game
