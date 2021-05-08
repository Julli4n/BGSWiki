local p = {}
function p.get(frame)
    local face = (require('Module:Faces_Infobox/Utilities:FaceStats'))[frame.args[1]]
    if face then
        if frame.args[2] == "currency" then
            return face.cost[2]
        elseif frame.args[2] == "cost" then
            return face.cost[1]
        else
            return face[frame.args[2]]
        end
    end
end
function p.checkFace(frame)
    if (require('Module:Faces_Infobox/Utilities:FaceStats'))[frame.args.face] or frame.args.namespace ~= "" then
        return frame.args.success
    else
        return frame.args.error or ''
    end
end
return p