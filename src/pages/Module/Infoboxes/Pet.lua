--[[
    Handler for the Pets Infobox
]]

-- Imports
local Settings = require("Module:Settings").Data

---@type CategoryHandlerCreator
local CategoryHandler = Settings.GetCategoryHandler()
---@type FindInTable
table.find = Settings.GetFindInTable()
---@type IsTableEmpty
table.isEmpty = Settings.GetIsTableEmpty()

---@type number[]
local ChanceMultipliers = Settings.GetChanceMultipliers()
---@type StatMultiplier[]
local StatMultipliers = Settings.GetStatMultipliers()
---@type string[]
local Rarities = Settings.GetRarities()
---@type string[]
local PetMovementTypes = Settings.GetPetMovementTypes()
---@type PetType[]
local PetTypes = Settings.GetPetTypes()
---@type Commafy
local Commafy = Settings.GetCommafy()

---@type table<string, Pet>
local Pets = Settings.GetPets()

local PetInfobox = {}
--Create an infobox node and return it
--
--INTERNAL USE ONLY, use PetInfobox.TemplateProxy for templates invoking the module
---@param frame Frame
function PetInfobox.Create(frame)
    
end

--Template Proxy for CreateInfobox, only use for tables
---@param frame Frame
function PetInfobox.TemplateProxy(frame)

end