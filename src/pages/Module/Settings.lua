--- Load modules
---
--- "other" should only exist if it's not for data (i.e. requiring an Infobox)
--- @param name string The path to the module.
--- @param other boolean Should it be loaded with `require()` or `mw.loadData()`, true for `require()`.
--- @return any
local function LoadModule(name, other)
	return function()
		local Module
		pcall(function() Module = other and require(name) or mw.loadData(name) end)
		return Module
	end
end

local Settings = {}

-- Set values
Settings.Data = {
	-- Get Data things for large values (function)
	GetPets = LoadModule("Module:Data/Pets"),
	GetHats = LoadModule("Module:Data/Hats"),
	GetGum = LoadModule("Module:Data/Gum"),
	GetFlavors = LoadModule("Module:Data/Flavors"),
	GetFaces = LoadModule("Module:Data/Faces"),
	GetCodes = LoadModule("Module:Data/Codes"),
	GetStatMultipliers = LoadModule("Module:Data/StatMultipliers"),
	GetChanceMultipliers = LoadModule("Module:Data/ChanceMultipliers"),
	GetRarities = LoadModule("Module:Data/Rarities"),
	GetPetMovementTypes = LoadModule("Module:Data/PetMovementTypes"),
	GetPetTypes = LoadModule("Module:Data/PetTypes"),
	-- Utils
	GetCategoryHandler = LoadModule("Module:Utils/CategoryHandler", true),
	GetFindInTable = LoadModule("Module:Utils/FindInTable", true),
	GetIsTableEmpty = LoadModule("Module:Utils/IsTableEmpty", true),
	GetCommafy = LoadModule("Module:Utils/Commafy", true),
	-- Data values (string | number | boolean)
	Color1 = "2bf8ff",
	Color2 = "ff5773"
}

return Settings