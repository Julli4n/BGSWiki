-- TODO: redo entire module
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
    "Flowers",
    "Robux",
    "Treats",
    "Tokens",
    "Bells",
    'Silver'
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
       'Token',
       'Token',
       'x'
   },
      ["Bells"] = {
       'Bell',
       'Bell',
       'x'
   },
         ["Silver"] = {
       'Silver',
       'Silver',
       'x'
   }
}
function split(str, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str2 in string.gmatch(str, "([^"..sep.."]+)") do
        table.insert(t, str2)
    end
    return t
end
function addCommas(str)
    return #tostring(str) % 3 == 0 and tostring(str):reverse():gsub("(%d%d%d)", "%1,"):reverse():sub(2) or tostring(str):reverse():gsub("(%d%d%d)", "%1,"):reverse()
end
local p = {}
function p.petTeam(frame)
    local petTable = {}
    local pets = (require('Module:Utilities/PetStats'))
    local hats = (require('Module:Utilities/HatStats'))
    for x,t in pairs(frame.args) do
        local petSp = split(t, ',')
        if type(x) == "number" and pets[petSp[1]] then
            local pet = petSp[1] 
            local level = (tonumber(petSp[2]) and tonumber(petSp[2]) <= 25 and tonumber(petSp[2]) or 25) or 1
            local enc = (tonumber(petSp[3]) and tonumber(petSp[3]) <= 50 and tonumber(petSp[3]) or 50) or 1
            local hat = (function()
                if hats[petSp[5]] then
                    return petSp[5]
                end
            end)()
            petTable[pet .. x] = {}
            petTable[pet .. x].rarity = pets[pet].rarity
            petTable[pet .. x].buffs = {}
            petTable[pet .. x].level = level
            petTable[pet .. x].enchant = enc
            petTable[pet .. x].hat = hat
            petTable[pet .. x].name = pet
            petTable[pet .. x].shiny = (function()
                if petSp[4] and petSp[4]:lower() == "shiny" then return true else return false end
            end)()
            petTable[pet .. x].mythic = (function()
                if petSp[6] and petSp[6]:lower() == "mythic" and pets[pet].hasMythic then return true else return false end
            end)()
            for i2,v in pairs(pets[pet].buffs) do
                local aStat = v
                if petTable[pet .. x].shiny == true then
                    aStat = v * 2
                end
                if petTable[pet .. x].mythic == true then
                    aStat = aStat * 1.5
                end
                local stat = aStat + ((aStat * 2) - aStat) * (level - 1) / (25 - 1)
                petTable[pet .. x].buffs[i2] =  stat + ((stat * 1.625) - stat) * enc / 50
            end
            if hat then
                for i3,v2 in pairs(hats[hat].buffs) do
                    petTable[pet .. x].buffs[i3] = (petTable[pet .. x].buffs[i3] or 0) + v2 
                end
            end
        end
    end
    local table = mw.html.create('table'):css('box-shadow', '0px 0px 0px 10px #ff5773'):css('border-radius', '10px'):css('background-color', '#fff'):css('margin-left', '10px'):css('width', '65%'):css('margin-top', '10px')
    local line = 0
    local tr = table:tag('tr'):css('align', 'center'):css('text-align', 'center')
    for i,v in pairs(petTable) do
        if line == 3 then
            tr = table:tag('tr'):css('align', 'center'):css('text-align', 'center')
            line = 0
        end
        local invert = ''
        if v.shiny == true then
            invert = 'invertIMG'
        end
        line = line + 1
        local td = tr:tag('td'):css('border', '3px solid #ffa1d1'):css('border-radius', '10px')
        local item = td:tag('div'):addClass('itemhover')
        item:tag('div'):addClass(invert):wikitext(('[[File:%s%s.png|100px|link=%s]]'):format(v.mythic == true and 'Mythic ' or '', (v.name:gsub('#', '-')), (v.name:gsub('#', '-'))))
        item:css('font-family', 'ComicNeue Angular'):css('font-size', '24px'):wikitext(('Level %s<br />Enchant %s'):format(v.level, v.enchant))
        local stats = item:tag('span'):addClass('text2')
        if v.shiny == true then
            stats:tag('span'):css('font-size', '24px', 'font-family', 'ComicNeue Angular'):css('color', '#FFE200'):css('-webkit-text-stroke', '0.8px black'):wikitext('SHINY')
            stats:tag('br')
        end
        if v.mythic == true then
            stats:tag('span'):css('font-size', '24px'):addClass('mythic'):wikitext('MYTHIC')
            stats:tag('br')
        end
        stats:tag('span'):css('font-family', 'ComicNeue Angular'):css('font-size', '26px'):wikitext(v.name)
        stats:tag('br')
        stats:tag('span'):addClass(v.rarity:lower()):wikitext(v.rarity)
        stats:tag('br')
        if v.hat then
            stats:tag('br')
            stats:css('font-family', 'ComicNeue Angular'):css('font-size', '24px'):wikitext(('Wearing [[File:%s.png|25px|link=%s]]'):format(v.hat, v.hat))
        end
        for i2 = 1, #currencies do
            if v.buffs[currencies[i2]] then
                stats:tag('br')
                local cur = currency[currencies[i2]]
                stats:tag('span'):addClass(cur[1]):wikitext(('[[File:%s.png|15px]]%s%s'):format(cur[2], cur[3], addCommas(math.ceil(v.buffs[currencies[i2]]))))
            end
        end
    end
    local total = {}
    for i,v in pairs(petTable) do
        for i,v in pairs(v.buffs) do
            if i == "Gifts" or i == "Tickets" or i == "Rainbows" then
                total.All = (total.All or 0) + v
            else
                total[i] = (total[i] or 0) + v
            end
        end
    end
    local ending = mw.html.create('div'):css('margin-top', '10px'):css('box-shadow', '0px 0px 0px 10px #F470B5'):css('border-radius', '10px'):css('background-color', '#fff'):css('margin-left', '10px'):css('width', '20%'):css('text-align', 'center')
    ending:tag('div'):css('text-align', 'center'):css('font-family', 'ComicNeue Angular'):css('font-size', '20px'):wikitext('Totals')
    for i = 1, #currencies do
        if total[currencies[i]] then
            local cur = currency[currencies[i]]
            ending:tag('span'):addClass(cur[1]):wikitext(('[[File:%s.png|15px]]%s%s'):format(cur[2], cur[3], addCommas(math.ceil(total[currencies[i]]))))
            ending:tag('br')
        end
    end
    return table, ending, mw.html.create('div'):css('margin-bottom', '20%')
end
setmetatable(p, {
    __index = function(self, index, value)
        return self.petTeam
    end
})
return p
