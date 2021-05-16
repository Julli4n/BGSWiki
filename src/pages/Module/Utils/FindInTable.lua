return function (t, str)
for _,v in pairs(t) do
    if tostring(v):lower() == tostring(str):lower() then 
        return str
    end
end
return false
end