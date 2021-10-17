-- DEPRECATED, DO NOT USE IN THE FUTURE

-- <nowiki>  Hide module's contents from the wikitext parser to avoid unwanted side effects

-- TODO: redo entire module
local ChanceMultis = { 1, 1.25, 2, 2.5, 4, 5, 8, 10 }
local Rarities = {
    "Common",
    "Unique",
    "Rare",
    "Epic",
    "Legendary",
    "Mythic"
}
local Types = {
    "Walk",
    "Fly"
}
local StatMultipliers = require('Module:Utilities/StatMultipliers')
local Pets = require('Module:Utilities/PetStats')
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
local function GetStatRating(pet)
    local Forbidden = {
        "Sylently's Pet",
        "Isaac's Creation"
    }
    local Pet = Pets[pet]
    local BestOfStat = {}
    for i,v in pairs(Pet.buffs) do
        BestOfStat[i] = 0
    end
    for i,v in pairs(Pets) do
        for i2,v2 in pairs(v.buffs) do
            if BestOfStat[i2] and BestOfStat[i2] < v2 and not table.find(Forbidden, i) then
                BestOfStat[i2] = v2
            end
        end
    end
    local Ratings = {}
    for i,v in pairs(Pet.buffs) do
        Ratings[i] = ((v / BestOfStat[i]) * (Pet.chance and 1 or 0.85)) * 5
    end
    local FinalRating = 0
    for i,v in pairs(Ratings) do
        FinalRating = FinalRating + v
    end
    return string.format("%2.1f", (FinalRating / 4))
end
function p.CreateInfobox(frame)
    local Namespace = frame:preprocess('{{NAMESPACE}}')
    if not Namespace then
        return ''
    end
    frame.args.PetName = frame.args.PetName and mw.text.decode(frame.args.PetName)
    if Namespace == '' and not Pets[frame.args.PetName] then
        return '[[Category:Pages with incorrect name inputs]]' 
    end    
    local RealPage = Namespace == '' and Pets[frame.args.PetName] and true or false
    local Info = {
        title = (RealPage and frame.args.PetName) or frame.args.title1 or frame.args.title or frame:getTitle(),
        image1 = frame.args.image1,
        image2 = frame.args.image2,
        image3 = frame.args.image3,
        image4 = frame.args.image4,
        caption1 = frame.args.caption1,
        caption2 = frame.args.caption2,
        caption3 = frame.args.caption3,
        caption4 = frame.args.caption4,
        Chance = (RealPage and Pets[frame.args.PetName].chance) or (not RealPage and frame.args.chance or ''),
        Rarity = (RealPage and Pets[frame.args.PetName].rarity) or (not RealPage and frame.args.rarity or ''),
        Type = (RealPage and Pets[frame.args.PetName].type) or (not RealPage and frame.args.type or ''),
        Bubbles = (RealPage and Pets[frame.args.PetName].buffs.Bubbles) or (not RealPage and frame.args.bubble or ''),
        Coins = (RealPage and Pets[frame.args.PetName].buffs.Coins) or (not RealPage and frame.args.coin or ''),
        Gems = (RealPage and Pets[frame.args.PetName].buffs.Gems) or (not RealPage and frame.args.jewel or frame.args.gem or ''),
        ["Candy Canes"] = (RealPage and Pets[frame.args.PetName].buffs["Candy Canes"]) or (not RealPage and frame.args.Candy or ''),
        Candy = (RealPage and Pets[frame.args.PetName].buffs.Candy) or not (not RealPage and frame.args["Candy-1"] or ''),
        Blocks = (RealPage and Pets[frame.args.PetName].buffs.Blocks) or (not RealPage and frame.args.Block or ''),
        Shells = (RealPage and Pets[frame.args.PetName].buffs.Shells) or (not RealPage and frame.args.Shell or ''),
        Pearls = (RealPage and Pets[frame.args.PetName].buffs.Pearls) or (not RealPage and frame.args.Pearl or ''),
        Stars = (RealPage and Pets[frame.args.PetName].buffs.Stars) or (not RealPage and frame.args.Star or ''),
        Magma = (RealPage and Pets[frame.args.PetName].buffs.Magma) or (not RealPage and frame.args.Magma or ''),
        ["Candy Corn"] = (RealPage and Pets[frame.args.PetName].buffs["Candy Corn"]) or (not RealPage and frame.args.CandyC),
        Gifts = (RealPage and Pets[frame.args.PetName].buffs.Gifts) or (not RealPage and frame.args.Gift or ''),
        Tickets = (RealPage and Pets[frame.args.PetName].buffs.Tickets) or (not RealPage and frame.args.Ticket or ''),
        Rainbows = (RealPage and Pets[frame.args.PetName].buffs.Rainbows) or (not RealPage and frame.args.Rainbow or ''),
        Crystals = (RealPage and Pets[frame.args.PetName].buffs.Crystals) or (not RealPage and frame.args.Crystal or ''),
        Flowers = (RealPage and Pets[frame.args.PetName].buffs.Flowers) or (not RealPage and frame.args.Flower or ''),
        Tokens = (RealPage and Pets[frame.args.PetName].buffs.Tokens) or (not RealPage and frame.args.Flower or ''),
        Treats = (RealPage and Pets[frame.args.PetName].buffs.Treats) or (not RealPage and frame.args.Treat or ''),
        Bells = (RealPage and Pets[frame.args.PetName].buffs.Bells) or (not RealPage and frame.args.Bell or ''),
        Silver = (RealPage and Pets[frame.args.PetName].buffs.Silver) or (not RealPage and frame.args.Silver or ''),
        All = (RealPage and Pets[frame.args.PetName].buffs.All) or (not RealPage and frame.args.All or ''),
        HasMythic = (RealPage and Pets[frame.args.PetName].hasMythic) or (not RealPage and frame.args.HasMythic or '')
    }
    for i,v in pairs(Info) do
        pcall(function()
            Info[i] = tonumber(tostring(string.gsub(v, ',', ''))) or Info[i]
        end)
        if v == '' or v == ' ' or string.match(tostring(v), '{{{([^}}}]+)') then Info[i] = nil end
    end
    local Infobox = ('<div id="Pets_%s" class="Pet_Infobox"><infobox>'):format(mw.uri.encode(Info.title, 'WIKI'))
    local function Add(str)    
        Infobox = ('%s%s'):format(Infobox, str)
    end
    local function done()
        Infobox = ('%s</infobox></div>'):format(Infobox)
        Infobox = frame:preprocess(Infobox)
    end
     Add(([[<title>
               <default>%s</default>
            </title>]]):format(Info.title or 'Missing Title'))
    Add('<panel name="stats">')
    local function addSection(name, image, caption, statm, chancem, rarity, invert, invertimg)
        name = name or 'Normal'
        caption = (image and (caption or '')) or 'Image currently unavailable'
        statm = statm or 1
        chancem = chancem or 1
        Add(([[<section name="%s">
                  <label>%s</label>
            ]]):format(name, name))
        if invert and not image and invertimg then
            Add(([===[<navigation>
                         <div style="margin-left: -9px; margin-top: -9px;" class="invertIMG">[[File:%s|268x268px]]</div><br /><div align="center">''Inverted HUE (may be an inaccurate representation)''</div>
                     </navigation>
                ]===]):format(invertimg))
        else
            Add(([[<image>
                       <caption>
                           <default>%s</default>
                       </caption>
                      <default>%s</default>
                  </image>]]):format(caption, image or 'DefaultShinyImage.png'))
        end
        if rarity and table.find(Rarities, rarity) then
            Add(([[<data>
                      <label>Rarity</label>
                      <default><span class="%s">%s</span></default>
                  </data>]]):format(string.lower(rarity), rarity))
        end
        if Info.Type and table.find(Types, Info.Type) then
            Add(([===[<data>
                          <label>Type</label>
                          <default><div style="font-family: ComicNeue Angular; font-size: 20px;" class="darken">[[File:%sing Type.png|24px]] %sing</div>
                          </default>
                      </data>]===]):format(Info.Type, Info.Type, Info.Type))
        end
        if Info.Bubbles then
            Add(([[<group>
                       <header>%s%sBase Stats</header>]]):format(name == 'Normal' and '' or name, name == 'Normal' and '' or ' '))
            for _,v in pairs(StatMultipliers) do
                if Info[v[1]] then
                    local stat = tonumber(Info[v[1]]) and commas(math.ceil(Info[v[1]] * statm)) or ('"%s" is not a number'):format(Info[v[1]])
                    Add(([===[<data>
                                  <label><div style="overflow:hidden;white-space:nowrap;">[[File:%s.png|15x15px|link=%s|right]]</div></label>
                                  <default><div style="overflow:hidden;white-space:nowrap;"><span class="%s">%s%s</span></div></default>
                              </data>
                        ]===]):format(v[3], v[1], v[2], v[4] or '', stat))
                end
            end
            Add([[<navigation>
                     <div align="center" class="calculator" /><br />
                  </navigation>]])
            if Info.title ~= "Sylently's Pet" and Info.title ~= "Isaac's Creation 2.0" and RealPage then
                Add(([===[<header>Stats Rating</header>
                          <data>
                              <default><div style="margin-left:-5px; margin-top: -10px; margin-bottom: -10px;"><center><font size="4">%s</font></center>[[File:PSR %s.png|280px]]</div></default>
                          </data>
                    ]===]):format(GetStatRating(Info.title), GetStatRating(Info.title)))
            end
            Add('</group>')
        end
        if Info.Chance and tonumber(Info.Chance) and Info.Rarity and Info.Rarity == 'Legendary' then
            local Default = tonumber(Info.Chance) / chancem
            Add([[<group collapse="closed">
                      <header>Chances</header>
                ]])
            for _,v in pairs(ChanceMultis) do
                Add(([[<data>
                           <label>%sx</label>
                           <default>'''%s%%''' (1 in %s chance)</default>
                       </data>
                    ]]):format(v, Default * v, commas(math.ceil(100 / (Default * v)))))
            end
            Add('</group>')
        end
        Add('</section>')
    end
    addSection('Normal', Info.image1, Info.caption1, 1, 1, Info.Rarity)
    if Info.HasMythic and tostring(Info.HasMythic):lower() == 'true' then
        addSection('Mythic', Info.image3, Info.caption3, 1.5, 200, 'Mythic')
    end
    addSection('Shiny', Info.image2, Info.caption2, 2, 100, Info.Rarity, true, Info.image1)
    if Info.HasMythic and tostring(Info.HasMythic):lower() == 'true' then
        addSection('Shiny Mythic', Info.image4, Info.caption4, 3, 20000, 'Mythic', true, Info.image3)
    end
    Add('</panel>')
    done()
    return RealPage and ('[[Category:Pets]] [[Category:%s Pets]] [[Category:%sing Pets]]'):format(Info.Rarity, Info.Type) or frame:preprocess('{{UserBlogWarn}}'), RealPage and Info.title ~= "Sylently's Pet" and Info.title ~= "Isaac's Creation 2.0" and  (('[[Category:Pets with a stat rating of %s]]'):format(GetStatRating(Info.title))) or '', Infobox
end
return p

-- </nowiki>  Hide module's contents from the wikitext parser to avoid unwanted side effects