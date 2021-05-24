---@class FindInTable
--Determine if a string can be found in a given table.
---@param t table Table to iterate over.
---@param str string String to find in the table.
---@return boolean result Whether or not the table includes the string.
return function (t, str)
    for _,v in pairs(t) do
        if tostring(v):lower() == tostring(str):lower() then 
            return str
        end
    end
    return false
end