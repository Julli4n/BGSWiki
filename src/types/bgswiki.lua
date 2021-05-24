--[[
    This file exists to manipulate lua-language-server for intellisense (glogally)
    
    DO NOT REQUIRE!
]]

---@class StatMultiplier
local StatMultiplier = {
    --Name of the stat multiplier, used for the label.
    ---@type string
    Name = "",

    --THe CSS class used for the stat multiplier.
    ---@type string
    CSSClass = "",

    --Icon name for the stat multiplier.
    ---@type string
    Icon = "",

    --Array of aliases that can be used in the Pets Infobox to identify the stat multiplier.
    ---@type string[]
    Aliases = {},

    --Prefix before the stat multiplier's number, usually to show addition or multiplication.
    ---@type string
    Prefix = "",

    --Array of internal potion names that can affect the stat.
    ---@type string[]
    AffectedBy = {}
}

---@class PetType
local PetType = {
    --Label to appear in the Infobox panel.
    ---@type string
    Label = "",

    --The number to multiply the initial stats by.
    ---@type number
    StatMultiplier = 0,

    --The number to multiply the initial chances by.
    ---@type number
    ChanceMultiplier = 0,

    --The image key to appear in the panel.
    ---@type string
    Image = "",

    --The caption key to appear below the Image in the panel.
    ---@type string
    Caption = "",

    --Whether or not it should invert `InvertImage` if `Image` key is nil.
    ---@type boolean
    Invert = true,

    --The image key to invert if `Image` key is nil and `Invert` is true.
    ---@type string | nil
    InvertImage = "",

    --Whether or not it requires `HasMythic` to be true to show.
    ---@type boolean
    RequiresMythic = true,

    --The "... Stats" header text to appear above the stats group.
    ---@type string
    StatsHeader = "',"
}

---@class Pet
local Pet = {
    --The rarity of the pet.
    ---@type string
    Rarity = "",

    --The movement type of the pet.
    ---@type string
    Type = "",

    --Table containing all the stats for the pet.
    ---@type table<string, number>
    Buffs = {},

    --Whether or not the Pet can have a mythic. When true, this will make types with `HasMythic` show onsite.
    ---@type boolean
    HasMythic = true,

    --The egg that the pet can be hatched from.
    ---@type string | nil
    Egg = "",

    --The chance (%) of the pet from the `Egg`.
    ---@type number | nil
    Chance = 0
}