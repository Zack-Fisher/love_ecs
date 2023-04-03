-- we use objects as ECS, and store the components at the entity id index
-- of the containing entity itself.
local table_lib = require("libs.table")

local objects = require("objects")

local Entity = {}

Entity.entities = {}

-- sometimes, we need to tag and delete a large specific subset of ents.
-- we'll do this through a key grouping system.
-- we bundle arrays of eids together in the Entity.groups.level {} table.
Entity.groups = {level = {}}

local ent_counter = 0

-- takes in an array table full of group names.
-- if no table is passed, then we default to a table with "level" specified.
function Entity.new(group_names)
    group_names = group_names or {group_one =  "level"}
    ent_counter = ent_counter + 1

    Entity.entities[#Entity.entities+1] = ent_counter

    for _, name in ipairs(group_names) do
        Entity.groups[name][#Entity.groups[name]+1] = ent_counter
    end

    return ent_counter
end

function Entity.remove(id)
    -- remove it from the global entities table
    table_lib.remove_value(Entity.entities, id)
    -- remove it from any groups it might be a part of
    for _, e_group in pairs(Entity.groups) do
        table_lib.remove_value(e_group, id)
    end
    -- remove any associated components with the entity.
    objects.remove_ent(id)
end

-- remove all entities inside the specified group.
-- this does not remove the group itself from the group table.
function Entity.remove_group(group_name)
    print("attempting to remove entities in group: " .. group_name)
    if not (table_lib.has_key(Entity.groups, group_name)) then
        print("could not find the group in the group table.")
        print("groups: " .. table_lib.dump(Entity.groups))
        return
    end

    for _, ent in ipairs(Entity.groups[group_name]) do
        Entity.remove(ent)
    end
end

--wrapper around the "class" constructor.
function Entity.append(ent, comp_name, ...)
    -- pass it directly to the constructor, which SHOULD BE IN EACH CLASS!!
    local component = objects.components[comp_name].new(ent, ...)

    return component
end

-- NOW, DEFINE SOME QUERY METHODS. --

-- use the table keys as an AND condition.
-- get all of the entities and related components with the specified components.
-- sample input:
-- (it depends on them both being dummy numbers.)
-- {transform = 0, class_name = 0}
-- =>
-- sample output:
-- {1: {transform: {...}, class_name: {...}}, 3: {transform: {...}, class_name: {...}}}
function Entity.comp_query(name_table)
    -- use this as an array of all the components it returns. 
    -- return the components themselves.
    local return_table = {}

    -- the ipairs just treats the table like an array. 
    -- DON'T USE IPAIRS IF THE KEYS MATTER!!
    for _, ent in ipairs(Entity.entities) do
        -- the temporary table that holds the components of the entity.
        local temp_table = table_lib.deep_copy(name_table)

        -- if it has all of the components the name table asked for, it's all good.
        -- add it to the final return, with index as the entity id.
        -- EFFICIENT!!!

        local sub_query = Entity.ent_query(ent, temp_table)

        if table_lib.all_values_non_number(sub_query) then
            return_table[ent] = sub_query
        end
    end

    return return_table
end

-- a table full of names to query for
function Entity.ent_query(ent, name_table)
    -- modify the values of the return table with the actual components. 
    local return_table = table_lib.deep_copy(name_table)

    for comp_name, comp in pairs(objects.components) do
        if table_lib.has_key(return_table, comp_name) then
            if comp.instances[ent] ~= nil then
                return_table[comp_name] = comp.instances[ent]
            end
        end
    end

    return return_table
end

return Entity
