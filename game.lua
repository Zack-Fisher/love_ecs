local Game = {}

local entity = require("entity")
local l = require("game.levelManager")

local one = require("game.one")
Game.levels = {one = one}

-- pass in a level module from Game.levels.
function Game.load_level(level_module)
    entity.remove_group("level")

    l.spawn_common()
    level_module.load()
end

return Game
