local p = {}
function p.get(frame)
    local multiplier = 1
    local hat = (require('Module:HatStats'))[frame.args[1]]
    if frame.args[3] then
        multiplier = frame.args[3]
    end
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
    local hat = (require('Module:HatStats'))[frame.args[1]]
    if hat and hat.crate and (hat.rarity == "Legendary" or hat.rarity == "Epic") then
        return true
    else
        return false
    end
end
return p
