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