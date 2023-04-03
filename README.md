# love_ecs
This is a small project featuring a simple game in an ECS-style made with LOVE.

### Running the game
Install "love" on your machine.
Then, clone this repository and cd into it.
Run
```bash
love .
```
and the game should start up.


### Adding component types
The following is a template component, placed in objects/component.lua:
```lua
local Component = {}

Component.instances = {}

function Component.new(ent, foo, bar, baz) -- put whatever params the constructor needs here
    -- optionally define default constructor arguments here
    -- foo = foo or 5
    local inst = {
        foo = foo,
        bar = bar,
        baz = baz,
    }

    -- add it to the required instances list
    Component.instances[ent] = inst

    -- not strictly necessary, but it's often nice to have this ent initializer function.
    Component.load(ent, inst)

    -- return the new instance at the end of the constructor
    return inst
end

function Component.load(ent, class_obj)

end

return Component
```

To use this component, go into objects.lua at the root of the project, and load in the module:
```lua
local component = require(objects.component)
```
Then, place the module table in the components table:
```lua
Objects.components.component = component
```
When querying for components, it will query based off of the names of the keys in the Objects.components table.

### Loading levels/loading entities/loading prefabs
Define this in some module in the filesystem:
```lua
-- definition for a level.
-- a level is a collection of entities.
local e = require("entity")
local p = require("prefab")

local one = {}

function one.load()
    -- entity constructor.
    -- the e.new() constructor can take a table array of strings, which are
    -- the groups the entity will be added to.
    -- by default, all entities are added to a "level" group.
    local ent = e.new()
    e.append(ent, "gravity", 20.0)

    -- prefabs are just functions that spawn entities.
    -- it's shorthand for the above syntax.
    p.NPC("assets/images/resa.png")
    p.fallingRockSpawner({x = 200, y = 10}, 64, 20, 20, 0.5)
end

return one
```
Then, put the module table data in the level table in game.lua:
```lua
local one = require("game.one")
Game.levels = {one = one}
```
Then, in love.load():
```lua
game.load_level(game.levels.one)
```

### Adding systems
```lua
-- a practical example of a system.
local function spriteRenderSystem()
    -- this query contains references to the component data of each of the entities
    -- that have both sprite AND aabb component data.
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
```
There are three main system types which will be automatically called at runtime: startup systems, update systems, and draw systems.
To apply systems to one of these types, add them to the corresponding table array:
```lua
-- adding our spriteRenderSystem to the draw system calls
local draw_systems = {
    -- ... other systems
    {condition = {}, system = spriteRenderSystem},
    -- ... other systems
}
```

After this, the systems should automatically run based on the call to system.lua in main.lua.
