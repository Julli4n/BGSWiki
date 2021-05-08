local p = {}
function p.get(frame)
    local flavor = (require('Module:Flavor_Infobox/Utilities:FlavorStats'))[frame.args[1]]
    if flavor then
        if frame.args[2] == "currency" then
            return flavor.cost[2]
        elseif frame.args[2] == "cost" then
            return flavor.cost[1]
        else
            return flavor[frame.args[2]]
        end
    end
end
function p.checkFlavor(frame)
    if (require('Module:Flavor_Infobox/Utilities:FlavorStats'))[frame.args.flavor] or frame.args.namespace ~= "" then
        return frame.args.success
    else
        return frame.args.error or ''
    end
end
return p