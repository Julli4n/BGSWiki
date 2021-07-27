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
--INTERNAL USE ONLY, use PetInfobox.TemplateProxy for templates using the module
---@param frame Frame
function PetInfobox.Create(frame)
    -- Get namespace for frame
    local Namespace = frame:preprocess("{{NAMESPACE}}")
    -- Determine if it's a real page
    local IsRealPage = Namespace == ""
    -- Don't judge, this is for easier access of information
    local Info = {
        Title = frame.args.PetName or frame.args.title1 or frame.args.title or mw.text.decode(frame:preprocess("{{PAGENAME}}")),
        Image1 = frame.args.image1,
        Image2 = frame.args.image2,
        Image3 = frame.args.image3,
        Image4 = frame.args.image4,
        Caption1 = frame.args.caption1,
        Caption2 = frame.args.caption2,
        Caption3 = frame.args.caption3,
        Caption4 = frame.args.caption4,
        Buffs = {}
    }
    local Pet = Pets[Info.Title]
    if Namespace == "" and not Pet then return CategoryHandler.New():Add("Pages with incorrect name inputs") end
    if IsRealPage then
        Info.Chance = Pet.Chance
        Info.Rarity = Pet.Rarity
        Info.Type = Pet.Type
        Info.HasMythic = Pet.HasMythic
        Info.Buffs = Pet.Buffs
    else
        Info.Chance = frame.args.chance
        Info.Rarity = frame.args.rarity
        Info.Type = frame.args.type
        Info.HasMythic = string.lower(tostring(frame.args.hasMythic)) == "true"
        -- Iterate over all Aliases for UGC pets
        for _,multiplier in ipairs(StatMultipliers) do
            for _,alias in ipairs(multiplier.Aliases) do 
                local Value = frame.args[alias]
                if Value then
                    Value = tonumber(tostring(string.gsub(Value, ",", "")))
                    Info.Buffs[multiplier.Name] = Value
                end
            end
        end
    end

    ---@type HTML
    local Infobox = mw.html.create("div"):attr("id", string.format("Pets_", mw.uri.encode(Info.Title, "WIKI"))):attr("class", "Pets_Infobox"):tag("infobox")
    Infobox:tag("title"):tag("default"):wikitext(Info.Title)
    local Panel = Infobox:tag("panel"):attr("name", "stats")

    -- Create panel sections
    for _,type in pairs(PetTypes) do
        -- If pet can exist as type
        if (not type.RequiresMythic) or type.RequiresMythic == Info.HasMythic then
            local Rarity = type.RequiresMythic and "Mythic" or Info.Rarity

            -- Image handling
            local Section = Panel:tag("section"):attr("name", type.Label)
            Section:tag("label"):wikitext(type.Label)
            if (type.Invert and not Info[type.Image]) and Info[type.InvertImage] then
                local Image = Section:tag("data"):tag("default")
                Image:tag("div"):addClass("invert-img"):cssText("margin-left:-14px; margin-top: -10px; margin-bottom: -10px;"):wikitext(string.format("[[File:%s|300px]]", Info[type.InvertImage]))
                Image:tag("br")
                Image:tag("div"):cssText("margin-left:4em;"):wikitext("''Inverted HUE (may be inaccurate)''")
            else
                local Image = Section:tag("image")
                Image:tag("caption"):tag("default"):wikitext(Info[type.Caption])
                Image:tag("default"):wikitext(Info[type.Image] or "DefaultShinyImage.png")
            end

            -- Rarity thing
            if Rarity and table.find(Rarities, Rarity) then
                local RarityTag = Section:tag("data")
                RarityTag:tag("label"):wikitext("Rarity")
                RarityTag:tag("default"):tag("span"):addClass(string.lower(Rarity)):wikitext(Rarity)
            end

            -- Movement type thing
            if Info.Type and table.find(PetMovementTypes, Info.Type) then
                local Type = Section:tag("data")
                Type:tag("label"):wikitext("Type")
                Type:tag("default"):tag("div"):cssText("font-family: ComicNeue Angular; font-size: 20px;"):addClass("darken"):wikitext(string.format("[[File:%sing Type.png|24px]] %sing", Info.Type, Info.Type))
            end

            -- Stats and calculator
            if not table.isEmpty(Info.Buffs) then
                local Stats = Section:tag("group")
                Stats:tag("header"):wikitext(type.StatsHeader)
                -- Stats
                for _,multiplier in ipairs(StatMultipliers) do
                    if Info.Buffs[multiplier.Name] then
                        local Stat = Stats:tag("data")
                        local StatValue = Commafy(math.ceil(Info.Buffs[multiplier.Name] * type.StatMultiplier))
                        Stat:tag("label"):tag("div"):wikitext(string.format("[[File:%s|15px]] %s", multiplier.Icon, multiplier.Name))
                        Stat:tag("default"):tag("div"):cssText("overflow:hidden;white-space:nowrap;"):tag("span"):attr("data-affected-by", string.gsub(mw.text.jsonEncode(multiplier.AffectedBy), "\"", "'")):addClass(multiplier.CSSClass):wikitext(string.format("%s%s", multiplier.Prefix, StatValue))
                    end
                end
                -- Calculator
                local Calculator = Stats:tag("data"):tag("default")
                Calculator:tag("center"):tag("div"):cssText("margin-left: 4.2em; margin-top: -10px; margin-bottom: -10px;"):addClass("calculator")
                Calculator:tag("br")
            end

            -- Chances list
            if Info.Chance and tonumber(Info.Chance) and Info.Rarity and Info.Rarity == "Legendary" then
                local Chances = Section:tag("group"):attr("collapse", "closed")
                local DefaultChance = tonumber(Info.Chance) / type.ChanceMultiplier
                Chances:tag("header"):wikitext("Chances")
                for _,chance in ipairs(ChanceMultipliers) do
                    local Chance = Chances:tag("data")
                    local CalculatedChance = Commafy(math.ceil(100 / (DefaultChance * chance)))
                    Chance:tag("label"):wikitext(string.format("%sx", chance))
                    Chance:tag("default"):wikitext(string.format("'''%s%%''' (1 in %s chance)", DefaultChance * chance, CalculatedChance))
                end
            end
        end
    end
    local Categories
    if IsRealPage then
        Categories = CategoryHandler.New():Add("Pets")
        if Info.Rarity then Categories:Add(string.format("%s Pets", Info.Rarity)) end
        if Info.Type then Categories:Add(string.format("%sing Pets", Info.Type)) end
    end
    return IsRealPage and Categories or frame:preprocess("{{UserBlogWarn}}"), frame:preprocess(tostring(Infobox))
end

--Template Proxy for CreateInfobox, only use for tables
---@param frame Frame
function PetInfobox.TemplateProxy(frame)
    return PetInfobox.Create(frame:getParent())
end

-- Create alias
PetInfobox.CreateInfobox = PetInfobox.Create

return PetInfobox