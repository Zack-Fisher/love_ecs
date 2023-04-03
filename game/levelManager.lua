-- objects that show up in each level are instantiated here.
-- also, there's some mgmt functions that should be useful, like respawning the player.
local e = require("entity")
local p = require("prefab")

local LevelManager = {}

function LevelManager.spawn_common()
    p.player()
end

function LevelManager.respawn_player()
    local query = e.comp_query({player = 0})

    if #query > 1 then
        return
    end
    p.player()
end

return LevelManager