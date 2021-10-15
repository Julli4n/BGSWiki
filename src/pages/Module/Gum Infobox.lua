-- DEPRECATED, DO NOT USE IN THE FUTURE

local StatMultipliers = require('Module:Utilities/StatMultipliers')
local Gums = require('Module:Utilities/GumStats')
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
local function FindMultiplier(multi)
    for _,v in pairs(StatMultipliers) do
        if string.lower(v[1]) == string.lower(multi) then
            return v
        end
    end
end
function p.CreateInfobox(frame)
    local Namespace = frame:preprocess('{{NAMESPACE}}')
    frame.args.GumName = frame.args.GumName and mw.text.decode(frame.args.GumName)
    if Namespace == '' and not Gums[frame.args.GumName] then
        return '[[Category:Pages with incorrect name inputs]]' 
    end
    local RealPage = Namespace == '' and Gums[frame.args.GumName] and true or false
    local Info = {
        title = (RealPage and frame.args.GumName) or frame.args.title1 or frame.args.title or frame:preprocess('{{PAGENAME}}'),
        image1 = frame.args.image1,
        caption1 = frame.args.caption1,
        Cost = (RealPage and Gums[frame.args.GumName].cost) or (not RealPage and frame.args.cost or ''),
        Capacity = (RealPage and Gums[frame.args.GumName].capacity) or (not RealPage and frame.args.capacity or '')
    }
    for i,v in pairs(Info) do
        pcall(function()
            Info[i] = tonumber(tostring(string.gsub(v, ',', ''))) or Info[i]
        end)
        if v == '' or v == ' ' or string.match(tostring(v), '{{{([^}}}]+)') then Info[i] = nil end
    end
    local Infobox = ('<div id="Gums_%s"><infobox>'):format(mw.uri.encode(Info.title, 'WIKI'))
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
    if type(Info.Cost) == 'string' then
        for _,v in pairs(StatMultipliers) do
            if string.lower(string.sub(Info.Cost, 1, #v[1])) == string.lower(v[1]) and tonumber(string.sub(Info.Cost, #v[1] + 1, -1)) then
                Info.Cost = {
                    tonumber(string.sub(Info.Cost, #v[1] + 1, -1)),
                    v[1]
                }
                break
            end
        end
    elseif type(Info.Cost) == 'table' and Info.Cost[1] == 'VIP' then
        Info.Cost[1] = 349
    elseif type(Info.Cost) == 'table' and Info.Cost[1] == 'Quantum Gum Gamepass' then
        Info.Cost[1] = 749
    end
    if Info.Cost and type(Info.Cost) == 'table' and Info.Cost[1] and type(Info.Cost[1]) == 'number' and Info.Cost[2] and type(Info.Cost[2]) == 'string' then
        local Stat = FindMultiplier(Info.Cost[2])
        Add(([===[<data>
                      <label><div style="overflow:hidden;white-space:nowrap;">[[File:%s.png|15x15px|link=%s|left]] Cost</div></label>
                      <default><div style="overflow:hidden;white-space:nowrap;"><span class="%s">%s</span></div></default>
                  </data>]===]):format(Stat[3], Stat[1], Stat[2], commas(Info.Cost[1])))
    end
    if Info.Capacity then
        Add([[<header>Stats</header>]])
        local Capacity = tonumber(Info.Capacity) and commas(math.ceil(Info.Capacity)) or ('"%s" is not a number'):format(Info.Capacity)
        Add(([===[<data>
                      <label><div style="overflow:hidden;white-space:nowrap;">[[File:Bubble.png|15x15px|link=Bubbles|right]]</div></label>
                      <default><div style="overflow:hidden;white-space:nowrap;"><span class="Bubble">%s</span></div></default>
                  </data>]===]):format(Capacity ~= 'nf' and Capacity or 'inf'))
    end
    done()
    return RealPage and ('[[Category:Gum]]') or frame:preprocess('{{UserBlogWarn}}'), Infobox
end

return p
