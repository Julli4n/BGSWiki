-- DEPRECATED, DO NOT USE IN THE FUTURE
-- <nowiki>  Hide module's contents from the wikitext parser to avoid unwanted side effects

local ChanceMultis = { 1, 1.25, 2, 2.5, 4, 5, 8, 10 }
local Rarities = {
    "Common",
    "Unique",
    "Rare",
    "Epic",
    "Legendary"
}
local StatMultipliers = require('Module:Utilities/StatMultipliers')
local Hats = require('Module:Utilities/HatStats')
local p = {}
function table.find(t, str)
    for _,v in pairs(t) do
        if tostring(v):lower() == tostring(str):lower() then 
            return str
        end
    end
    return false
end
local function commas(str)
    str = tostring(str)
    return #str % 3 == 0 and str:reverse():gsub("(%d%d%d)", "%1,"):reverse():sub(2) or str:reverse():gsub("(%d%d%d)", "%1,"):reverse()
end
local function GetStatRating(hat)
    local Hat = Hats[hat]
    local BestOfStat = {}
    for i,v in pairs(Hat.buffs) do
        BestOfStat[i] = 0
    end
    for i,v in pairs(Hats) do
        for i2,v2 in pairs(v.buffs) do
            if BestOfStat[i2] and BestOfStat[i2] < v2 then
                BestOfStat[i2] = v2
            end
        end
    end
    local Ratings = {}
    for i,v in pairs(Hat.buffs) do
        Ratings[i] = ((v / BestOfStat[i]) * (Hat.chance and 1 or 0.85)) * 5
    end
    local FinalRating = 0
    for i,v in pairs(Ratings) do
        FinalRating = FinalRating + v
    end
    return string.format("%2.1f", (FinalRating / 4))
end
function p.CreateInfobox(frame)
    local Namespace = frame:preprocess('{{NAMESPACE}}')
    if Namespace == '' and not Hats[frame.args.HatName] then
        return '[[Category:Pages with incorrect name inputs]]' 
    end
    local RealPage = Namespace and Hats[frame.args.HatName] and true or false
    local Info = {
        title = (RealPage and frame.args.HatName) or frame.args.title1 or frame.args.title or frame:preprocess('{{PAGENAME}}'),
        image1 = frame.args.image1,
        caption1 = frame.args.caption1,
        Chance = (RealPage and Hats[frame.args.HatName].chance) or (not RealPage and frame.args.chance or ''),
        Rarity = (RealPage and Hats[frame.args.HatName].rarity) or (not RealPage and frame.args.rarity or ''),
        Bubbles = (RealPage and Hats[frame.args.HatName].buffs.Bubbles) or (not RealPage and frame.args.bubble or ''),
        Coins = (RealPage and Hats[frame.args.HatName].buffs.Coins) or (not RealPage and frame.args.coin or ''),
        Gems = (RealPage and Hats[frame.args.HatName].buffs.Gems) or (not RealPage and frame.args.jewel or frame.args.gem or ''),
        ["Candy Canes"] = (RealPage and Hats[frame.args.HatName].buffs["Candy Canes"]) or (not RealPage and frame.args.Candy or ''),
        Candy = (RealPage and Hats[frame.args.HatName].buffs.Candy) or (not RealPage and frame.args["Candy-1"] or ''),
        Blocks = (RealPage and Hats[frame.args.HatName].buffs.Blocks) or (not RealPage and frame.args.Block or ''),
        Shells = (RealPage and Hats[frame.args.HatName].buffs.Shells) or (not RealPage and frame.args.Shell or ''),
        Pearls = (RealPage and Hats[frame.args.HatName].buffs.Pearls) or (not RealPage and frame.args.Pearl or ''),
        Stars = (RealPage and Hats[frame.args.HatName].buffs.Stars) or (not RealPage and frame.args.Star or ''),
        Magma = (RealPage and Hats[frame.args.HatName].buffs.Magma) or (not RealPage and frame.args.Magma or ''),
        ["Candy Corn"] = (RealPage and Hats[frame.args.HatName].buffs["Candy Corn"]) or (not RealPage and frame.args.CandyC or ''),
        Gifts = (RealPage and Hats[frame.args.HatName].buffs.Gifts) or (not RealPage and frame.args.Gift or ''),
        Tickets = (RealPage and Hats[frame.args.HatName].buffs.Tickets) or (not RealPage and frame.args.Ticket or ''),
        Rainbows = (RealPage and Hats[frame.args.HatName].buffs.Rainbows) or (not RealPage and frame.args.Rainbow or ''),
        Crystals = (RealPage and Hats[frame.args.HatName].buffs.Crystals) or (not RealPage and frame.args.Crystal or ''),
        Flowers = (RealPage and Hats[frame.args.HatName].buffs.Flowers) or (not RealPage and frame.args.Flower or ''),
        All = (RealPage and Hats[frame.args.HatName].buffs.All) or (not RealPage and frame.args.All or '')
    }
    for i,v in pairs(Info) do
        pcall(function()
            Info[i] = tonumber(tostring(string.gsub(v, ',', ''))) or Info[i]
        end)
        if v == '' or v == ' ' or string.match(tostring(v), '{{{([^}}}]+)') then Info[i] = nil end
    end
    local Infobox = ('<div id="Hats_%s" class="Hat_Infobox"><infobox>'):format(mw.uri.encode(Info.title, 'WIKI'))
    local function Add(str)    
        Infobox = ('%s%s'):format(Infobox, str)
    end
    local function done()
        Infobox = ('%s</infobox>'):format(Infobox)
        Infobox = frame:preprocess(Infobox)
    end
     Add(([[<title>
               <default>%s</default>
            </title>]]):format(Info.title or 'Missing Title'))
     Info.caption1 = (Info.image1 and (Info.caption1 or '')) or 'Image currently unavailable'
     Add(([[<image>
                <caption>
                    <default>%s</default>
                </caption>
                <default>%s</default>
            </image>]]):format(Info.caption1, Info.image1 or 'DefaultShinyImage.png'))
    if Info.Rarity and table.find(Rarities, Info.Rarity) then
        Add(([[<data>
                  <label>Rarity</label>
                  <default><span class="%s">%s</span></default>
               </data>]]):format(string.lower(Info.Rarity), Info.Rarity))
    end
    if Info.Bubbles then
        Add([[<group>
                  <header>Stats</header>]])
        for _,v in pairs(StatMultipliers) do
            if Info[v[1]] then
                local stat = tonumber(Info[v[1]]) and commas(math.ceil(Info[v[1]])) or ('"%s" is not a number'):format(Info[v[1]])
                Add(([===[<data>
                              <label><div style="overflow:hidden;white-space:nowrap;">[[File:%s.png|15x15px|link=%s|right]]</div></label>
                              <default><div style="overflow:hidden;white-space:nowrap;"><span class="%s">%s%s</span></div></default>
                          </data>
                        ]===]):format(v[3], v[1], v[2], v[4] or '', stat))
            end
        end
    end
    if RealPage then
        Add(([===[<header>Stats Rating</header>
                      <data>
                          <default><div style="margin-left:-5px; margin-top: -10px; margin-bottom: -10px;"><center><font size="4">%s</font></center>[[File:PSR %s.png|280px]]</div></default>
                      </data>
                    ]===]):format(GetStatRating(Info.title), GetStatRating(Info.title)))
    end
    Add('</group>')
    if Info.Chance and tonumber(Info.Chance) and Info.Rarity and Info.Rarity == 'Legendary' then
        local Default = tonumber(Info.Chance)
        Add([[<group collapse="closed">
                  <header>Chances</header>]])
        for _,v in pairs(ChanceMultis) do
            Add(([[<data>
                       <label>%sx</label>
                       <default>'''%s%%''' (1 in %s chance)</default>
                  </data>]]):format(v, Default * v, commas(math.ceil(100 / (Default * v)))))
        end
        Add('</group>')
    end
    done()
    return RealPage and ('[[Category:Hats]] [[Category:%s Hats]]'):format(Info.Rarity) or frame:preprocess('{{UserBlogWarn}}'), RealPage and ('[[Category:Hats with a stat rating of %s]]'):format(GetStatRating(Info.title)) or '', Infobox
end

return p

-- </nowiki>  Hide module's contents from the wikitext parser to avoid unwanted side effects
