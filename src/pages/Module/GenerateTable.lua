-- TODO: redo entire module
local p ={}
local currencies = {
    "Bubbles",
    "Coins",
    "Gems",
    "Candy Canes",
    "Candy",
    "Blocks",
    "Shells",
    "Pearls",
    "Stars",
    "Magma",
    "Candy Corn",
    "Gifts",
    "Tickets",
    "All",
    "Rainbows",
    "Crystals",
    "Robux",
    "Flowers",
    "Tokens",
    "Treats",
    "Bells",
    "Silver"
}
local currency = {
    ["Bubbles"] = { 
        "Bubble",
        "Bubble",
        "+"
    }, 
    ["Coins"] = {
        "Coin",
        "Coin",
        "x"
    },
    ["Gems"] = {
        "Jewel",
        "Jewel",
        "x"
    },
    ["Candy Canes"] = {
        "Candy",
        "Candy Cane",
        "x"
    },
    ["Candy"] = {
        "Candy-1",
        "Candy",
        "x"
    },
    ["Blocks"] = {
        "Block",
        "Block",
        "x"
    },
    ["Shells"] = {
        "Shell",
        "Shell",
        "x"
    },
    ["Pearls"] = {
        "Pearl",
        "Pearl",
        "x"
    },
    ["Stars"] = {
        "Star",
        "Star",
        "x"
    },
    ["Magma"] = {
        "Magma",
        "Magma",
        "x"
    },
    ["Candy Corn"] = {
        "CandyC",
        "CandyC",
        "x"
    },
    ["Gifts"] = {
        "Gift",
        "Gift",
        "x"
    },
    ["Tickets"] = {
        "Ticket",
        "Ticket",
        "x"
    },
    ["Rainbows"] = {
        "Rainbows",
        "Rainbows",
        "x"
    },
    ["All"] = {
        "All",
        "All",
        "x"
    }, 
    ["Crystals"] = {
        "Crystal",
        "Crystal Icon",
        "x"
    },
    ["Robux"] = {
        "Robux",
        "Icon-Robux",
        ""
    },
   ["Flowers"] = {
       "Flower",
       "Flower",
       "x"
   },
      ["Treats"] = {
       "Treat",
       "Treat",
       "x"
   },
      ["Tokens"] = {
       "Token",
       "Token",
       "x"
          },
      ["Bells"] = {
       "Bell",
       "Bell",
       "x"
   },
      ["Silver"] = {
       "Silver",
       "Silver",
       "x"
   }
}
function spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end
function addCommas(str)
    return #tostring(str) % 3 == 0 and tostring(str):reverse():gsub("(%d%d%d)", "%1,"):reverse():sub(2) or tostring(str):reverse():gsub("(%d%d%d)", "%1,"):reverse()
end
function p.pets(frame)
    local EggTable = {}
    for i,v in pairs(require('Module:Utilities/PetStats')) do
        if v.egg == frame.args[1] or v.egg == "All Egg" then
            EggTable[i] = v.chance
        end
    end
    local table = mw.html.create('table'):addClass('hidden'):css('box-shadow', '0px 0px 0px 10px #ff5773'):css('border-radius', '10px'):css('background-color', '#fff'):css('margin-left', '10px'):css('width', '40%'):css('margin-top', '10px')
    local line = 0
    local tr = table:tag('tr'):css('align', 'center'):css('text-align', 'center')
    for i,v in spairs(EggTable, function(t,a,b) return t[b] < t[a] end) do
        if line == 3 then
            tr = table:tag('tr'):css('align', 'center'):css('text-align', 'center')
            line = 0
        end
        line = line + 1
        local pet = (require('Module:Utilities/PetStats'))[i]
        local td = tr:tag('td')
        local pet1 = td:tag('div'):addClass('itemhover')
        pet1:wikitext(('[[File:%s.png|100px|link=%s]]'):format(string.gsub(i, '#', '-'), (i:gsub('#', '-'))))
        pet1:tag('br')
        pet1:tag('span'):addClass('text'):addClass(pet.rarity:lower()):wikitext(('%s%%'):format(pet.chance))
        local info = pet1:tag('span'):addClass('text2')
        info:css('font-family', 'ComicNeue Angular'):css('font-size', '26px'):wikitext(i)
        info:tag('br')
        info:tag('span'):addClass(pet.rarity:lower()):wikitext(pet.rarity)
        for i2 = 1, #currencies do
            if pet.buffs[currencies[i2]] then
                info:tag('br')
                local cur = currency[currencies[i2]]
                info:tag('span'):addClass(cur[1]):wikitext(('[[File:%s.png|15px]]%s%s'):format(cur[2], cur[3], addCommas(pet.buffs[currencies[i2]])))
            end
        end
    end
    return table, mw.html.create('div'):css('margin-bottom', '18%')
end
function p.hats(frame)
    local CrateTable = {}
    for i,v in pairs(require('Module:Utilities/HatStats')) do
        if v.crate == frame.args[1] then
            CrateTable[i] = v.chance
        end
    end
    local table = mw.html.create('table'):addClass('hidden'):css('box-shadow', '0px 0px 0px 10px #FA6122'):css('border-radius', '10px'):css('background-color', '#fff'):css('margin-left', '10px'):css('width', '40%'):css('margin-top', '10px')
    local line = 0
    local tr = table:tag('tr'):css('align', 'center'):css('text-align', 'center')
    for i,v in spairs(CrateTable, function(t,a,b) return t[b] < t[a] end) do
        if line == 3 then
            tr = table:tag('tr'):css('align', 'center'):css('text-align', 'center')
            line = 0
        end
        line = line + 1
        local hat = (require('Module:Utilities/HatStats'))[i]
        local td = tr:tag('td')
        local hat1 = td:tag('div'):addClass('itemhover')
        hat1:wikitext(('[[File:%s.png|100px|link=%s]]'):format((i:gsub('#', '-')), (i:gsub('#', '-'))))
        hat1:tag('br')
        hat1:tag('span'):addClass('text'):addClass(hat.rarity:lower()):wikitext(('%s%%'):format(hat.chance))
        local info = hat1:tag('span'):addClass('text2')
        info:css('font-family', 'ComicNeue Angular'):css('font-size', '26px'):wikitext(i)
        info:tag('br')
        info:tag('span'):addClass(hat.rarity:lower()):wikitext(hat.rarity)
        for i2 = 1, #currencies do
            if hat.buffs[currencies[i2]] then
                info:tag('br')
                local cur = currency[currencies[i2]]
                info:tag('span'):addClass(cur[1]):wikitext(('[[File:%s.png|15px]]%s%s'):format(cur[2], cur[3], addCommas(hat.buffs[currencies[i2]])))
            end
        end
    end
    return table, mw.html.create('div'):css('margin-bottom', '18%')
end
function p.flavors(frame)
    local FlavorTable = {}
    for i,v in pairs(require('Module:Flavor_Infobox/Utilities:FlavorStats')) do
        if v.store == frame.args[1] then
            if v.cost[1] == "VIP" then
                FlavorTable[i] = 0
            else
                FlavorTable[i] = v.cost[1]
            end
        end
    end
    local table = mw.html.create('table'):addClass('hidden'):css('box-shadow', '0px 0px 0px 10px #FA6122'):css('border-radius', '10px'):css('background-color', '#fff'):css('margin-left', '10px'):css('width', '40%'):css('margin-top', '10px')
    local line = 0
    local tr = table:tag('tr'):css('align', 'center'):css('text-align', 'center')
    for i,v in spairs(FlavorTable, function(t,a,b) return t[b] > t[a] end) do
        if line == 3 then
            tr = table:tag('tr'):css('align', 'center'):css('text-align', 'center')
            line = 0
        end
        line = line + 1
        local flavor = (require('Module:Flavor_Infobox/Utilities:FlavorStats'))[i]
        local cur = currency[flavor.cost[2]]
        local td = tr:tag('td')
        local flavor1 = td:tag('div'):addClass('itemhover'):css('overflow', 'hidden'):css('white-space', 'nowrap')
        flavor1:wikitext(('[[File:%s.png|100px|link=%s]]'):format((i:gsub('#', '-')), (i:gsub('#', '-'))))
        flavor1:tag('br')
        flavor1:tag('span'):addClass('text'):addClass(cur[1]):wikitext(('[[File:%s.png|15px]]%s'):format(cur[2], (function()
                if flavor.cost[1] == "VIP" then
                    return 349
                else
                    return addCommas(flavor.cost[1])
                end
            end)()))
        local info = flavor1:tag('span'):addClass('text2')
        info:css('font-family', 'ComicNeue Angular'):css('font-size', '26px'):wikitext(i)
        info:tag('br')
        info:tag('span'):addClass('Bubble'):wikitext(('[[File:Bubble.png|15px]]+%s'):format(addCommas(flavor.bubbles)))
    end
    return table, mw.html.create('div'):css('margin-bottom', '10%')
end
function p.faces(frame)
    local FacesTable = {}
    for i,v in pairs(require('Module:Faces_Infobox/Utilities:FaceStats')) do
        if v.store == frame.args[1] then
            FacesTable[i] = v.cost[1]
        end
    end
    local table = mw.html.create('table'):addClass('hidden'):css('box-shadow', '0px 0px 0px 10px #FA6122'):css('border-radius', '10px'):css('background-color', '#fff'):css('margin-left', '10px'):css('width', '40%'):css('margin-top', '10px')
    local line = 0
    local tr = table:tag('tr'):css('align', 'center'):css('text-align', 'center')
    for i,v in spairs(FacesTable, function(t,a,b) return t[b] > t[a] end) do
        if line == 3 then
            tr = table:tag('tr'):css('align', 'center'):css('text-align', 'center')
            line = 0
        end
        line = line + 1
        local face = (require('Module:Faces_Infobox/Utilities:FaceStats'))[i]
        local cur = currency[face.cost[2]]
        local td = tr:tag('td')
        local face1 = td:tag('div'):addClass('itemhover'):css('overflow', 'hidden'):css('white-space', 'nowrap')
        face1:wikitext(('[[File:%s.png|100px|link=%s]]'):format((i:gsub('#', '-')), (i:gsub('#', '-'))))
        face1:tag('br')
        face1:tag('span'):addClass('text'):addClass(cur[1]):wikitext(('[[File:%s.png|15px]]%s'):format(cur[2], addCommas(face.cost[1])))
        local info = face1:tag('span'):addClass('text2')
        info:css('font-family', 'ComicNeue Angular'):css('font-size', '26px'):wikitext(i)
        info:tag('br')
        info:tag('span'):addClass('Bubble'):wikitext(('[[File:Bubble.png|15px]]+%s'):format(addCommas(face.bubbles)))
    end
    return table, mw.html.create('div'):css('margin-bottom', '10%')
end
function p.gum(frame)
    local GumTable = {}
    for i,v in pairs(require('Module:Gum_Infobox/Utilities:GumStats')) do
        if v.store == frame.args[1] then
            if type(v.cost[1]) == "string" then
                GumTable[i] = 0
            else
                GumTable[i] = v.cost[1]
            end
        end
    end
    local table = mw.html.create('table'):addClass('hidden'):css('box-shadow', '0px 0px 0px 10px #FA6122'):css('border-radius', '10px'):css('background-color', '#fff'):css('margin-left', '10px'):css('width', '40%'):css('margin-top', '10px')
    local line = 0
    local tr = table:tag('tr'):css('align', 'center'):css('text-align', 'center')
    for i,v in spairs(GumTable, function(t,a,b) return t[b] > t[a] end) do
        if line == 3 then
            tr = table:tag('tr'):css('align', 'center'):css('text-align', 'center')
            line = 0
        end
        line = line + 1
        local gum = (require('Module:Gum_Infobox/Utilities:GumStats'))[i]
        local cur = currency[gum.cost[2]]
        local td = tr:tag('td')
        local gum1 = td:tag('div'):addClass('itemhover'):css('overflow', 'hidden'):css('white-space', 'nowrap')
        gum1:wikitext(('[[File:%s.png|100px|link=%s]]'):format((i:gsub('#', '-')), (i:gsub('#', '-'))))
        gum1:tag('br')
        gum1:tag('span'):addClass('text'):addClass(cur[1]):wikitext(('[[File:%s.png|15px]]%s'):format(cur[2], (function()
                if gum.cost[1] == "VIP" then
                    return 349
                elseif gum.cost[1] == "Quantum Gum Gamepass" then
                    return 749
                else
                    return addCommas(gum.cost[1])
                end
            end)()))
        local info = gum1:tag('span'):addClass('text2')
        info:css('font-family', 'ComicNeue Angular'):css('font-size', '26px'):wikitext(i)
        info:tag('br')
        info:tag('span'):addClass('Bubble'):wikitext(('[[File:Bubble.png|15px]]%s'):format(addCommas(gum.capacity)))
    end
    return table, mw.html.create('div'):css('margin-bottom', '10%')
end
local StatMultipliers = require('Module:Utilities/StatMultipliers')
local function FindMultiplier(multi)
    for _,v in pairs(StatMultipliers) do
        if string.lower(v[1]) == string.lower(multi) then
            return v
        end
    end
end
function p.Generate(limit, info)
    local Table = mw.html.create('table'):addClass('hidden'):css('box-shadow', '0px 0px 0px 10px #009DFF'):css('border-radius', '10px'):css('background-color', '#fff'):css('margin-left', '10px'):css('width', '40%'):css('margin-top', '10px')
    local Line = 0
    local Tr = Table:tag('tr'):css('align', 'center'):css('text-align', 'center')
    for i,v in pairs(info) do
        if Line == limit then
            Tr = Table:tag('tr'):css('align', 'center'):css('text-align', 'center')
            Line = 0
        end
        Line = Line + 1
        local Td = Tr:tag('td'):css('white-space', 'nowrap'):addClass('hidden'):addClass('itemhover')
        local Info = ''
        for _,v2 in pairs(v[1]) do
            Info = ('%s%s%s'):format(Info, Info ~= '' and '<br/>' or '', v2)
        end
        local Hover = Td:tag('div'):addClass('text'):wikitext(Info)
        local HoverInfo = ''
        for _,v2 in pairs(v[2]) do
            HoverInfo = ('%s%s%s'):format(HoverInfo, HoverInfo ~= '' and '<br/>' or '', v2)
        end
        Hover:tag('div'):addClass('text2'):wikitext(HoverInfo)
    end
    return Table
end
function p.ThisIsATest()
    return p.Generate(3, { 
        { { "[[File:Bruh.png|100px]]", 'a bruh moment'}, { "I hide stats yes" } },
        { { "[[File:Bruh.png|100px]]", 'a bruh moment'}, { "I hide stats yes" } },
        { { "[[File:Bruh.png|100px]]", 'a bruh moment'}, { "I hide stats yes" } },
        { { "[[File:Bruh.png|100px]]", 'a bruh moment'}, { "I hide stats yes" } },
        { { "[[File:Bruh.png|100px]]", 'a bruh moment'}, { "I hide stats yes" } }
    })
end
return p