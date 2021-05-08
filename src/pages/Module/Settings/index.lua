--[=[ 
- Module:Settings from the Bubble Gum Simulator Wiki on Fandom. https://bubble-gum-simulator.fandom.com
- Redistribution and reference is permitted as long as proper attribution is given (per CC BY-SA), but direct re-usage is not recommended as this Lua code was and is created specifically for the Bubble Gum Simulator Wiki
- See https://www.fandom.com/licensing for more information about licensing
]=]
local Data = mw.loadData('Module:Settings/data')
return function(name, environment)
	return (name and Data[name]) and (environment and Data[name][environment] or Data[name].Default) or {}
end