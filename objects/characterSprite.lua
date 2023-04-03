local table_lib = require("libs.table")
local character = require("objects.character")

local CharacterSprite = {}

CharacterSprite.instances = {}

-- this goes down a spritesheet in a specific format.
-- rpgmaker 2003 charset format.
function CharacterSprite.new(ent, spritesheet_path, animation_speed)
    animation_speed = animation_speed or 8

    -- create the table, then initialize the actual quads used for rendering.
    local inst = {
        spritesheet_path = spritesheet_path,
        -- index starting from two.
        index = 2,
        animation_speed = animation_speed,
        quads = {},
        tilewidth = 24,
        tileheight = 32,
        tilesPerRow = 3,
        tilesPerColumn = 4,
        tileset = love.graphics.newImage(spritesheet_path)
    }

    local tileset = inst.tileset

    -- Define the tile size and number of tiles per row and column
    local tilewidth = inst.tilewidth
    local tileheight = inst.tileheight
    local tilesPerRow = inst.tilesPerRow
    local tilesPerColumn = inst.tilesPerColumn

    -- Cut the tileset into separate quads for each walking direction
    -- read top to bottom, left to right and chop each quad into its own direction subtable.
    -- i hope it'll iterate left to right through the directions, the format
    -- expects a certain directional order.
    print("cutting the tileset for the CharacterSprite")

    for _, direction in pairs(character.directions) do
        inst.quads[direction] = {}
        for x = 0, tilesPerRow-1 do
            local quad = love.graphics.newQuad(x*tilewidth, (direction-1)*tileheight, tilewidth, tileheight, tileset:getDimensions())
            table.insert(inst.quads[direction], quad)
        end
    end

    CharacterSprite.instances[ent] = inst

    CharacterSprite.load(ent, inst)

    return inst
end

function CharacterSprite.load(ent, class_obj)
    print("adding CharacterSprite component")
    print(table_lib.dump(class_obj), " at entity id: " .. ent)
end

return CharacterSprite