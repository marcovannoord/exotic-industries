-- vanilla patches like changed entities/prototypes are made here

local ei_lib = require("lib/lib")
local ei_data = require("lib/data")

--====================================================================================================
--GENERIC CHANGES
--====================================================================================================

-- since there is no iron gear used in EI use iron-mechanical parts instead
for i,v in pairs(data.raw["recipe"]) do
    ei_lib.recipe_swap(i, "iron-gear-wheel", "ei_iron-mechanical-parts")
    ei_lib.recipe_swap(i, "iron-stick", "ei_iron-mechanical-parts")
end


--====================================================================================================
--CHANGES
--====================================================================================================

--MINING
------------------------------------------------------------------------------------------------------

-- set output of copper and iron ore to ore chunks
data.raw["resource"]["iron-ore"].minable.result = "ei_poor-iron-chunk"
data.raw["resource"]["copper-ore"].minable.result = "ei_poor-copper-chunk"

-- set furnace result inv to 2
for i,v in pairs(data.raw["furnace"]) do
    data.raw["furnace"][i].result_inventory_size = 2
end

--LABS
------------------------------------------------------------------------------------------------------

data.raw["lab"]["lab"].inputs = ei_data.lab_inputs["lab"]

--RECIPES
------------------------------------------------------------------------------------------------------

-- overwrite table for vanilla recipes
-- index is recipe name, value is table with new recipe data
local new_ingredients_table = {
    ["iron-plate"] = {
        {"ei_iron-ingot", 1}
    },
    ["copper-plate"] = {
        {"ei_copper-ingot", 1}
    },
    ["transport-belt"] = {
        {"iron-plate", 1},
        {"ei_iron-mechanical-parts", 2}
    },
    ["burner-inserter"] = {
        {"iron-plate", 1},
        {"ei_copper-mechanical-parts", 2}
    },
    ["repair-pack"] = {
        {"ei_copper-mechanical-parts", 3},
        {"ei_iron-mechanical-parts", 3} 
    },
    ["iron-chest"] = {
        {"iron-plate", 8},
        {"ei_iron-beam", 2} 
    },
    ["gun-turret"] = {
        {"iron-plate", 5},
        {"ei_iron-mechanical-parts", 5},
        {"ei_copper-mechanical-parts", 5}
    },
    ["heavy-armor"] = {
        {"iron-plate", 40},
        {"ei_iron-beam", 10},
        {"ei_copper-beam", 10}
    },
    ["stone-wall"] = {
        {"stone-brick", 3},
        {"ei_iron-beam", 1} 
    },
    ["offshore-pump"] = {
        {"ei_copper-mechanical-parts", 4},
        {"ei_iron-beam", 2},
        {"pipe", 2}
    },
    ["train-stop"] = {
        {"ei_iron-beam", 2},
        {"ei_iron-mechanical-parts", 2},
        {"copper-plate", 2}
    },
    ["rail-signal"] = {
        {"ei_copper-mechanical-parts", 1},
        {"iron-plate", 1}
    },
    ["rail-chain-signal"] = {
        {"ei_copper-mechanical-parts", 1},
        {"iron-plate", 1}
    },
    ["steel-furnace"] = {
        {"steel-plate", 4},
        {"stone-brick", 10},
        {"stone-furnace", 1}
    },
    ["gate"] = {
        {"stone-wall", 1},
        {"ei_iron-beam", 2},
        {"ei_copper-mechanical-parts", 4}
    },
    ["oil-refinery"] = {
        {"pipe", 10},
        {"ei_copper-beam", 20},
        {"steel-plate", 15},
        {"ei_steel-mechanical-parts", 10},
        {"stone-brick", 10}
    },
    ["engine-unit"] = {
        {"ei_steam-engine", 1},
        {"ei_copper-mechanical-parts", 1},
        {"ei_iron-mechanical-parts", 1}
    },
    ["lab"] = {
        {"ei_dark-age-lab", 1},
        {"ei_copper-mechanical-parts", 10},
        {"ei_iron-mechanical-parts", 10},
        {"electronic-circuit", 10}
    },
    ["electric-engine-unit"] = {
        {"engine-unit", 1},
        {"copper-cable", 4},
        {"ei_iron-mechanical-parts", 2}
    },
    ["steam-engine"] = {
        {"pipe", 5},
        {"electric-engine-unit", 4},
        {"ei_steam-engine", 4},
        {"ei_iron-beam", 2}
    },
    ["inserter"] = {
        {"electric-engine-unit", 1},
        {"burner-inserter", 1},
        {"electronic-circuit", 2}
    },
    ["medium-electric-pole"] = {
        {"ei_copper-beam", 4},
        {"ei_iron-mechanical-parts", 2},
        {"ei_insulated-wire", 2}
    },
    ["big-electric-pole"] = {
        {"steel-plate", 8},
        {"ei_iron-mechanical-parts", 2},
        {"ei_insulated-wire", 4}
    },
    ["substation"] = {
        {"steel-plate", 6},
        {"ei_insulated-wire", 6},
        {"electronic-circuit", 6},
        {"concrete", 50}
    },
    ["concrete"] = {
        {"ei_poor-iron-chunk", 5},
        {"stone-brick", 10},
        {"ei_sand", 4}
    },
    ["assembling-machine-1"] = {
        {"electronic-circuit", 2},
        {"electric-engine-unit", 2},
        {"ei_iron-beam", 2},
        {"ei_copper-mechanical-parts", 4}
    },
    ["chemical-plant"] = {
        {"ei_heat-chemical-plant", 1},
        {"electronic-circuit", 2},
        {"electric-engine-unit", 2},
    },
    ["roboport"] = {
        {"advanced-circuit", 45},
        {"concrete", 50},
        {"ei_steel-mechanical-parts", 45},
        {"steel-plate", 45}
    },
    ["logistic-robot"] = {
        {"advanced-circuit", 4},
        {"steel-plate", 4},
        {"flying-robot-frame", 1}
    },
    ["construction-robot"] = {
        {"electronic-circuit", 4},
        {"steel-plate", 4},
        {"flying-robot-frame", 1}
    },
    ["modular-armor"] = {
        {"advanced-circuit", 25},
        {"heavy-armor", 10},
        {"iron-plate", 25},
    },
    ["exoskeleton-equipment"] = {
        {"ei_steel-mechanical-parts", 10},
        {"advanced-circuit", 10},
        {"electric-engine-unit", 25},
    },
    ["discharge-defense-equipment"] = {
        {"advanced-circuit", 10},
        {"steel-plate", 10},
        {"ei_insulated-wire", 45},
    },
    ["power-armor"] = {
        {"modular-armor", 2},
        {"electric-engine-unit", 40},
        {"advanced-circuit", 40},
        {"ei_energy-crystal", 100},
    },
    ["energy-shield-equipment"] = {
        {"advanced-circuit", 10},
        {"steel-plate", 10},
        {"ei_energy-crystal", 25},
    },
    ["personal-laser-defense-equipment"] = {
        {"laser-turret", 6},
        {"steel-plate", 10},
        {"ei_energy-crystal", 25},
    },
    ["laser-turret"] = {
        {"steel-plate", 20},
        {"advanced-circuit", 10},
        {"battery", 12},
        {"ei_energy-crystal", 10},
    },
    ["solar-panel"] = {
        {"ei_semiconductor", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 4},
    },
    ["electric-furnace"] = {
        {"concrete", 25},
        {"ei_steel-mechanical-parts", 15},
        {"advanced-circuit", 10},
        {"steel-furnace", 1},
    },
    ["radar"] = {
        {"electronic-circuit", 5},
        {"steel-plate", 6},
        {"ei_iron-mechanical-parts", 10},
        {"electric-engine-unit", 4},
    },
    ["electric-mining-drill"] = {
        {"electric-engine-unit", 4},
        {"electronic-circuit", 4},
        {"ei_iron-beam", 3},
        {"ei_iron-mechanical-parts", 5},
    },
    ["storage-tank"] = {
        {"steel-plate", 8},
        {"ei_iron-beam", 4},
        {"pipe", 4},
    },
}

data.raw["recipe"]["iron-plate"].category = "crafting"
data.raw["recipe"]["iron-plate"].energy_required = 1

data.raw["recipe"]["copper-plate"].category = "crafting"
data.raw["recipe"]["copper-plate"].energy_required = 1

data.raw["recipe"]["burner-mining-drill"].normal.ingredients = {
    {"iron-plate", 3},
    {"ei_iron-mechanical-parts", 3},
    {"stone-furnace", 1}
}

data.raw["recipe"]["burner-mining-drill"].expensive.ingredients = {
    {"iron-plate", 3},
    {"ei_iron-mechanical-parts", 3},
    {"stone-furnace", 1}
}

data.raw["recipe"]["pipe"].normal.ingredients = {
    {"iron-plate", 1},
    {"ei_iron-beam", 1}
}

data.raw["recipe"]["pipe"].expensive.ingredients = {
    {"iron-plate", 2},
    {"ei_iron-beam", 2}
}

data.raw["recipe"]["electronic-circuit"].normal.ingredients = {
    {"ei_electron-tube", 1},
    {"copper-cable", 2},
    {"iron-plate", 1}
}

data.raw["recipe"]["electronic-circuit"].expensive.ingredients = {
    {"ei_electron-tube", 1},
    {"copper-cable", 2},
    {"iron-plate", 1}
}

data.raw["recipe"]["basic-oil-processing"].ingredients =
{
    {type="fluid", name="crude-oil", amount=100},
    {type="fluid", name="water", amount=20},
}
data.raw["recipe"]["basic-oil-processing"].results = 
{
    {type="fluid", name="ei_residual-oil", amount=55},
    {type="fluid", name="petroleum-gas", amount=45},
}

data.raw["recipe"]["sulfuric-acid"].ingredients = {
    {type="fluid", name="water", amount=100},
    {type="item", name="ei_crushed-iron", amount=2},
    {type="item", name="sulfur", amount=5}

}

-- treat red belts with plastic
data.raw["recipe"]["fast-transport-belt"].ingredients = {
    {type="item", name="transport-belt", amount=1},
    {type="item", name="ei_iron-mechanical-parts", amount=5},
    {type="item", name="plastic-bar", amount=2}
}
data.raw["recipe"]["fast-underground-belt"].ingredients = {
    {type="item", name="underground-belt", amount=2},
    {type="item", name="ei_iron-mechanical-parts", amount=30},
    {type="item", name="plastic-bar", amount=6}
}
data.raw["recipe"]["fast-splitter"].ingredients = {
    {type="item", name="splitter", amount=1},
    {type="item", name="ei_iron-mechanical-parts", amount=12},
    {type="item", name="electronic-circuit", amount=8},
    {type="item", name="plastic-bar", amount=4}
}

-- red circuits need sulfuric acid
ei_lib.recipe_new("advanced-circuit",
{
    {type="item", name="electronic-circuit", amount=2},
    {type="item", name="ei_insulated-wire", amount=4},
    {type="item", name="ei_electron-tube", amount=2},
    {type="fluid", name="sulfuric-acid", amount=25}
})
data.raw["recipe"]["advanced-circuit"].category = "crafting-with-fluid"

-- batteries
ei_lib.recipe_new("battery",
{
    {type="item", name="ei_crushed-iron", amount=6},
    {type="item", name="ei_crushed-copper", amount=6},
    {type="item", name="ei_ceramic", amount=2},
    {type="fluid", name="sulfuric-acid", amount=45}
})

-- robo frames
data.raw["recipe"]["flying-robot-frame"].category = "crafting-with-fluid"
ei_lib.recipe_new("flying-robot-frame",
{
    {"electric-engine-unit", 4},
    {"battery", 2},
    {"advanced-circuit", 5},
    {"ei_steel-mechanical-parts", 10},
    {"ei_energy-crystal", 1},
    {type="fluid", name="lubricant", amount=100}
})

-- treat cracking
data.raw["recipe"]["heavy-oil-cracking"].icon = ei_graphics_other_path.."heavy-cracking.png"
data.raw["recipe"]["heavy-oil-cracking"].icon_size = 64
data.raw["recipe"]["heavy-oil-cracking"].results = {
    {type="fluid", name="ei_kerosene", amount=40},
}
ei_lib.recipe_new("heavy-oil-cracking",
{
    {type="fluid", name="heavy-oil", amount=50},
    {type="fluid", name="water", amount=40}
})


--TECHS
------------------------------------------------------------------------------------------------------

local new_prerequisites_table = {}

-- first index is tech second is prerequisite
new_prerequisites_table["steam-age"] = {
    {"refined-flammables-1", "flammables"},
    {"refined-flammables-2", "refined-flammables-1"},
    {"flamethrower", "flammables"},
    {"flammables", "ei_steam-oil-processing"},
    {"physical-projectile-damage-2", "military-2"},
    {"weapon-shooting-speed-2", "military-2"},
    {"automated-rail-transportation", "ei_steam-basic-train"},
    -- {"railway", "ei_steam-power"},
    -- {"fluid-wagon", "railway"},
    {"rail-signals", "ei_steam-basic-train"},
    {"braking-force-1", "ei_steam-basic-train"},
    {"braking-force-2", "braking-force-1"},
    -- {"fluid-wagon", "fluid-handling"},
    {"stronger-explosives-1", "military-2"},
    {"gate", "military-2"},
    {"automobilism", "military-2"},
    {"automobilism", "engine"},
    {"flammables", "military-2"},
    {"flammethrower", "steel-processing"},
    {"flammethrower", "engine"},
    {"inserter-capacity-bonus-1", "ei_steam-inserter"},
    {"steel-processing", "ei_steam-crusher"},
    {"advanced-material-processing", "steel-processing"},
    -- {"fluid-handling", "steel-processing"},
    {"military-2", "steel-processing"},
    {"steel-axe", "steel-processing"},
    {"engine", "ei_steam-oil-processing"},
    {"electronics", "ei_glass"},
}

new_prerequisites_table["electricity-age"] = {
    {"electric-energy-distribution-1", "plastics"},
    {"electric-energy-distribution-2", "plastics"},
    {"electric-energy-distribution-2", "concrete"},
    {"automation", "ei_electricity-power"},
    {"automation-2", "automation"},
    {"fast-inserter", "ei_electricity-power"},
    {"circuit-network", "ei_electricity-power"},
    {"optics", "ei_electricity-power"},
    {"laser", "optics"},
    {"laser-turret", "laser"},
    {"energy-weapons-damage-1", "laser"},
    {"energy-weapons-damage-2", "energy-weapons-damage-1"},
    {"laser-shooting-speed-1", "laser"},
    {"laser-shooting-speed-2", "laser-shooting-speed-1"},
    {"laser-shooting-speed-3", "laser-shooting-speed-2"},
    {"laser", "military-3"},
    {"tank", "military-3"},
    {"physical-projectile-damage-3", "military-3"},
    {"land-mine", "military-3"},
    {"stronger-explosives-2", "military-3"},
    {"refined-flammables-3", "military-3"},
    {"refined-flammables-4", "refined-flammables-3"},
    {"physical-projectile-damage-4", "physical-projectile-damage-3"},
    {"cliff-explosives", "explosives"},
    {"worker-robots-speed-2", "worker-robots-speed-1"},
    {"robotics", "lubricant"},
    {"robotics", "advanced-electronics"},
    {"robotics", "battery"},
    {"robotics", "ei_grower"},
    {"logistic-robotics", "robotics"},
    {"construction-robotics", "robotics"},
    {"worker-robots-speed-1", "robotics"},
    {"personal-roboport-equipment", "robotics"},
    -- {"logistic-system", "logistic-robotics"},
    -- {"logistic-system", "construction-robotics"},
    {"defender", "robotics"},
    {"distractor", "defender"},
    {"destroyer", "distractor"},
    {"follower-robot-count-1", "defender"},
    {"follower-robot-count-2", "follower-robot-count-1"},
    {"modular-armor", "military-3"},
    {"power-armor", "modular-armor"},
    {"braking-force-3", "railway"},
    {"fluid-wagon", "railway"},
    {"lubricant", "ei_destill-tower"},
    {"railway", "fluid-handling"},
    {"railway", "sulfur-processing"},
    {"braking-force-4", "braking-force-3"},
    {"braking-force-5", "braking-force-4"},
    {"energy-shield-equipment", "power-armor"},
    {"night-vision-equipment", "modular-armor"},
    {"belt-immunity-equipment", "modular-armor"},
    {"exoskeleton-equipment", "modular-armor"},
    {"battery-equipment", "modular-armor"},
    {"solar-panel-equipment", "modular-armor"},
    {"personal-laser-defense-equipment", "power-armor"},
    {"discharge-defense-equipment", "modular-armor"},
    {"inserter-capacity-bonus-2", "fast-inserter"},
    {"sulfur-processing", "ei_destill-tower"},
    {"oil-processing", "plastics"},
    {"coal-liquefaction", "ei_benzol"},
    {"coal-liquefaction", "sulfur-processing"},
    {"advanced-oil-processing", "ei_destill-tower"},
    {"battery", "sulfur-processing"},
    {"electric-energy-accumulators", "battery"},
    {"lubricant", "automation-2"},
    {"logistics-2", "plastics"},
    {"advanced-electronics", "sulfur-processing"},
    {"advanced-electronics", "automation-2"},
    {"inserter-capacity-bonus-2", "lubricant"},
    {"construction-robotics", "concrete"},
    {"logistic-robotics", "concrete"},
    {"explosives", "sulfur-processing"},
    {"military-3", "explosives"},
    {"modular-armor", "advanced-electronics"},
    {"battery-equipment", "battery"},
    {"solar-panel-equipment", "solar-energy"},
    {"personal-laser-defense-equipment", "laser-turret"},
    {"laser", "ei_grower"},
    {"laser", "advanced-electronics"},
    {"personal-roboport-equipment", "modular-armor"},
    {"power-armor", "ei_grower"},
    {"solar-energy", "ei_waver-factory"},
    {"advanced-material-processing-2", "advanced-electronics"},
    {"advanced-material-processing-2", "concrete"},
    
}

data.raw["technology"]["steel-processing"].icon = ei_graphics_tech_path.."steel-processing.png"
data.raw["technology"]["fluid-handling"].icon = ei_graphics_tech_path.."barreling.png"
data.raw["technology"]["fluid-handling"].icon_size = 256

table.insert(data.raw["technology"]["engine"].effects, {
    type = "unlock-recipe",
    recipe = "pump"
})

table.insert(data.raw["technology"]["optics"].effects, {
    type = "unlock-recipe",
    recipe = "radar"
})

data.raw["technology"]["electronics"].effects = {
    {
        type = "unlock-recipe",
        recipe = "ei_electron-tube"
    },
    {
        type = "unlock-recipe",
        recipe = "electronic-circuit"
    },
    {
        type = "unlock-recipe",
        recipe = "copper-cable"
    },
    {
        type = "unlock-recipe",
        recipe = "ei_ceramic"
    }
}

-- remove vanilla steel recipe from tech effects
ei_lib.remove_unlock_recipe("steel-processing", "steel-plate")
ei_lib.remove_unlock_recipe("fluid-handling", "storage-tank")
ei_lib.remove_unlock_recipe("fluid-handling", "pump")
ei_lib.remove_unlock_recipe("automation", "long-handed-inserter")
ei_lib.remove_unlock_recipe("oil-processing", "oil-refinery")
ei_lib.remove_unlock_recipe("oil-processing", "basic-oil-processing")
ei_lib.remove_unlock_recipe("oil-processing", "solid-fuel-from-petroleum-gas")
ei_lib.remove_unlock_recipe("advanced-oil-processing", "advanced-oil-processing")

-- edit electric enigne tech to use only steam age science for progression
data.raw["technology"]["electric-engine"].unit.ingredients = ei_data.science["steam-age"]

--HIDE FOR LATER USE
------------------------------------------------------------------------------------------------------

-- logistic
-- data.raw["recipe"]["inserter"].hidden = true
data.raw["recipe"]["small-electric-pole"].enabled = false

data.raw["recipe"]["pipe-to-ground"].enabled = false

-- machines
data.raw["recipe"]["boiler"].enabled = false
data.raw["recipe"]["offshore-pump"].enabled = false
data.raw["recipe"]["lab"].enabled = false

-- intermediates
data.raw["recipe"]["copper-cable"].enabled = false
data.raw["recipe"]["iron-stick"].hidden = true
data.raw["recipe"]["automation-science-pack"].hidden = true
data.raw["recipe"]["steel-plate"].normal.hidden = true
data.raw["recipe"]["steel-plate"].expensive.hidden = true

-- military
data.raw["recipe"]["radar"].enabled = false

-- expensive/normal variants
data.raw["recipe"]["pipe"].normal.enabled = false
data.raw["recipe"]["pipe"].expensive.enabled = false
data.raw["recipe"]["steam-engine"].normal.enabled = false
data.raw["recipe"]["steam-engine"].expensive.enabled = false
data.raw["recipe"]["electric-mining-drill"].normal.enabled = false
data.raw["recipe"]["electric-mining-drill"].expensive.enabled = false
data.raw["recipe"]["iron-gear-wheel"].normal.enabled = false
data.raw["recipe"]["iron-gear-wheel"].expensive.enabled = false
data.raw["recipe"]["electronic-circuit"].normal.enabled = false
data.raw["recipe"]["electronic-circuit"].expensive.enabled = false

--FUEL CATEGORIES
------------------------------------------------------------------------------------------------------

-- introduce diesel and rocket fuels
data.raw["item"]["rocket-fuel"].fuel_category = "ei_rocket-fuel"
data.raw["item"]["nuclear-fuel"].fuel_category = "ei_rocket-fuel"

--ITEM SUBGROUPS
------------------------------------------------------------------------------------------------------

-- move iron and copper plates to plates subgroup
data.raw["item"]["iron-plate"].subgroup = "ei_refining-plate"
data.raw["item"]["iron-plate"].order = "a1"
data.raw["item"]["copper-plate"].subgroup = "ei_refining-plate"
data.raw["item"]["copper-plate"].order = "a2"

-- set train, cargo wagon, fluid wagon and artillery wagon to new ei_trains subgroup
data.raw["item-with-entity-data"]["locomotive"].subgroup = "ei_trains"
data.raw["item-with-entity-data"]["locomotive"].order = "c1"
data.raw["item-with-entity-data"]["cargo-wagon"].subgroup = "ei_trains"
data.raw["item-with-entity-data"]["cargo-wagon"].order = "c2"
data.raw["item-with-entity-data"]["fluid-wagon"].subgroup = "ei_trains"
data.raw["item-with-entity-data"]["fluid-wagon"].order = "c3"
data.raw["item-with-entity-data"]["artillery-wagon"].subgroup = "ei_trains"
data.raw["item-with-entity-data"]["artillery-wagon"].order = "c4"

data.raw["item"]["steel-plate"].subgroup = "ei_refining-beam"
data.raw["item"]["steel-plate"].order = "a3"

data.raw["item"]["lab"].subgroup = "ei_labs"
data.raw["item"]["lab"].order = "a2"

data.raw["fluid"]["lubricant"].order = "a[fluid]-d[lubricant]"

--OTHER
------------------------------------------------------------------------------------------------------

-- set new steel-plate icon
data.raw["item"]["steel-plate"].icon = ei_graphics_item_path.."steel-plate.png"

-- set fluid burn values for crude, light, heavy - oil and petrol
data.raw["fluid"]["crude-oil"].fuel_value = "150kJ"
data.raw["fluid"]["heavy-oil"].fuel_value = "100kJ"
data.raw["fluid"]["light-oil"].fuel_value = "100kJ"
data.raw["fluid"]["petroleum-gas"].fuel_value = "400kJ"

-- make diesel barrel a fuel
data.raw["item"]["ei_diesel-barrel"].fuel_category = "ei_diesel-fuel"
data.raw["item"]["ei_diesel-barrel"].fuel_value = "20MJ"
data.raw["item"]["ei_diesel-barrel"].burnt_result = "empty-barrel"

-- make locomotive use diesel and rocket fuel
-- add burnt fuel slot
data.raw["locomotive"]["locomotive"].burner.fuel_categories = {
    "ei_diesel-fuel",
    "ei_rocket-fuel"
}
data.raw["locomotive"]["locomotive"].burner.burnt_inventory_size = 1

-- make oil-refinery heat based
data.raw["assembling-machine"]["oil-refinery"].energy_source = {
    type = 'heat',
    max_temperature = 275,
    min_working_temperature = 185,
    specific_heat = ei_data.specific_heat,
    max_transfer = '10MW',
    connections = {
        {position = {-2.3, 0}, direction = defines.direction.west},
        {position = {-2.3, 1}, direction = defines.direction.west},
        {position = {-2.3, -1}, direction = defines.direction.west},
        -- {position = {0,1.4}, direction = defines.direction.south},
        {position = {2.3, 0}, direction = defines.direction.east},
        {position = {2.3, 1}, direction = defines.direction.east},
        {position = {2.3, -1}, direction = defines.direction.east},
        -- {position = {-1.5,0}, direction = defines.direction.west}
    }
}

-- make pump not use energy
data.raw["pump"]["pump"].energy_source = {
    type = 'void'
}

-- make burner inserter be able to fuel leech
data.raw["inserter"]["burner-inserter"].allow_burner_leech = true

-- make electric engine unit craft category be crafting
data.raw["recipe"]["electric-engine-unit"].category = "crafting"

--====================================================================================================
--FUNCTION STUFF
--====================================================================================================

-- loop over new_ingredients_table and set new ingredients for indexed recipes
for i,v in pairs(new_ingredients_table) do
    ei_lib.recipe_new(i, v)
end

-- loop over new_prerequisites_table and add new prerequisites for indexed technologies
-- if so remove the age tech as prerequisiter
for age,table_in in pairs(new_prerequisites_table) do
    for i,v in pairs(table_in) do
        ei_lib.add_prerequisite(v[1], v[2])
        ei_lib.remove_prerequisite(v[1], "ei_"..age)
    end
end