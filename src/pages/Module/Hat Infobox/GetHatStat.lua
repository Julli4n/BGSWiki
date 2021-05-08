local p = {}
function p.get(frame)
    local multiplier = frame.args[3] or 1
    local hat = (require('Module:Hat_Infobox/Utilities:HatStats'))[frame.args[1]]
    if frame.args[2] == "rarity" or frame.args[2] == "crate" then
        return hat[frame.args[2]]
    else
        if hat.buffs[frame.args[2]] then 
            return hat.buffs[frame.args[2]] * multiplier
        else
            return hat[frame.args[2]] * multiplier
        end
    end
end
function p.canBeUnboxed(frame)
    local hat = (require('Module:Hat_Infobox/Utilities:HatStats'))[frame.args[1]]
    if hat and hat.crate and (hat.rarity == "Legendary" or hat.rarity == "Epic") then
        return true
    else
        return false
    end
end
function p.getHatRating(frame)
    local hat = (require('Module:Hat_Infobox/Utilities:HatStats'))[frame.args[1]]
    local bestOfStat = {}
    for i,v in pairs(hat.buffs) do
        bestOfStat[i] = 0
    end
    for i,v in pairs(require('Module:Hat_Infobox/Utilities:HatStats')) do
        for i2,v2 in pairs(v.buffs) do
            if bestOfStat[i2] and bestOfStat[i2] < v2 then
                bestOfStat[i2] = v2
            end
        end
    end
    local ratings = {}
    for i,v in pairs(hat.buffs) do
        ratings[i] = (v / bestOfStat[i]) * 5
    end
    local finalRating = 0
    for i,v in pairs(ratings) do
        finalRating = finalRating + v
    end
    return string.format("%2.1f", (finalRating / 4))
end
function p.doesStatExist(frame)
    local hat = (require('Module:Hat_Infobox/Utilities:HatStats'))[frame.args[1]]
    if hat and (hat[frame.args[2]] or hat.buffs[frame.args[2]]) then
        return true
    else
        return false
    end
end
function p.checkHat(frame)
    if (require('Module:Hat_Infobox/Utilities:HatStats'))[frame.args.hat] or frame.args.namespace ~= "" then
        return frame.args.success
    else
        return frame.args.error or ''
    end
end
return p
