--[=[ 
- Module:Settings/data from the Bubble Gum Simulator Wiki on Fandom. https://bubble-gum-simulator.fandom.com
- Redistribution and reference is permitted as long as proper attribution is given (per CC BY-SA), but direct re-usage is not recommended as this Lua code was and is created specifically for the Bubble Gum Simulator Wiki
- See https://www.fandom.com/licensing for more information about licensing
]=]
local function LoadModule(name, other)
	local Module
	pcall(function() Module = other and require(name) or mw.loadData(name) end)
	return Module
end
return {
	Global = {
		Default = {
			Pets = LoadModule("Module:PetData"),
			Hats = LoadModule("Module:HatData"),
			Gum = LoadModule("Module:GumData"),
			Flavors = LoadModule("Module:FlavorData"),
			Faces = LoadModule("Module:FaceData"),
			Codes = LoadModule("Module:CodeData"),
			Color1 = "2bf8ff",
			Color2 = "ff5773"
		}
	}
}