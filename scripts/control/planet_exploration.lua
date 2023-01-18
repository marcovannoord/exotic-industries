local model = {}

--====================================================================================================
--PLANET EXPLORATION
--====================================================================================================

--UTIL
------------------------------------------------------------------------------------------------------

model.destination_dict = ei_data.planet_exploration.destination_dict
model.return_dict = ei_data.planet_exploration.return_dict

function model.entity_check(entity)

    if entity == nil then
        return false
    end

    if not entity.valid then
        return false
    end

    return true
end


function model.get_destination(entity)

    if model.entity_check(entity) == false then
        return
    end

    local recipe = entity.get_recipe()

    if recipe == nil then
        return nil
    end
    -- string part after ei_rocket: is the destination
    local destination = string.sub(recipe.name, 11)

    return destination

end


function model.set_destination(entity, destination)

    if model.entity_check(entity) == false then
        return
    end

    recipe_name = model.destination_dict[destination]

    if recipe_name == nil then
        return
    end

    entity.set_recipe(recipe_name)
    entity.recipe_locked = true

end


function model.set_initial_destination(entity)

    -- return if recipe is already set f.e. due to blueprint
    if model.get_destination(entity) then
        return
    end

    model.set_destination(entity, "nauvis-orbit")

end


function model.give_launch_products(silo, rocket)

    rocket_inv = rocket.get_inventory(defines.inventory.rocket)
    if rocket_inv.is_empty() then
        return
    end

    silo_inv = silo.get_inventory(defines.inventory.rocket_silo_result)

    destination = model.get_destination(silo)
    if destination == nil then
        return
    end

    if model.return_dict[destination] == nil then
        return
    end

    -- loop over all items in rocket and give launch products
    for item, count in pairs(rocket_inv.get_contents()) do

        if count == 0 then
            goto continue
        end

        if model.return_dict[destination][item] == nil then
            goto continue
        end

        local return_spec = model.return_dict[destination][item]

        if silo_inv.can_insert({name = return_spec.name, count = return_spec.count}) then
            silo_inv.insert({name = return_spec.name, count = return_spec.count})
        end

        ::continue::
    end

end

--HANDLERS
------------------------------------------------------------------------------------------------------

function model.on_built_entity(entity)

    if model.entity_check(entity) == false then
        return
    end

    if entity.name == "rocket-silo" then
        model.set_initial_destination(entity)
    end

end


function model.on_rocket_launched(event)

    silo = event.rocket_silo
    rocket = event.rocket

    if model.entity_check(silo) == false then
        return
    end

    model.give_launch_products(silo, rocket)

end


return model