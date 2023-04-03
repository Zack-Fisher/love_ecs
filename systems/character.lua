local SCharacter = {}
--systems that run over character/npc component types.

local entity = require("entity")
local c = require("objects.character")

local table_lib = require("libs.table")

function SCharacter.characterSpriteRenderSystem()
    local query = entity.comp_query({characterSprite = 0, aabb = 0, character = 0})

    for ent, ent_q in pairs(query) do
        local characterSprite = ent_q.characterSprite
        local aabb = ent_q.aabb
        local character = ent_q.character

        -- lua doesn't have matching/cases damn
        local i = characterSprite.index

        local height = characterSprite.tileheight
        local width = characterSprite.tilewidth
        local quads = characterSprite.quads

        love.graphics.draw(
            characterSprite.tileset,
            quads[character.direction][i],
            aabb.x,
            aabb.y
        )

        if character.is_moving then
            characterSprite.index = characterSprite.index + 1
            characterSprite.index = (characterSprite.index % 3) + 1
        else
            characterSprite.index = 2
        end
    end
end


return SCharacter
