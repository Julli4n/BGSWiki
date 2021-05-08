local p = {}
function p.get(frame)
    local gum = (require('Module:Gum_Infobox/Utilities:GumStats'))[frame.args[1]]
    if gum then
        if frame.args[2] == "currency" then
            return gum.cost[2]
        elseif frame.args[2] == "cost" then
            return gum.cost[1]
        else
            return gum[frame.args[2]]
        end
    end
end
function p.checkGum(frame)
    if (require('Module:Gum_Infobox/Utilities:GumStats'))[frame.args.gum] or frame.args.namespace ~= "" then
        return frame.args.success
    else
        return frame.args.error or ''
    end
end
return p
