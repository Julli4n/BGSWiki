---@class IsTableEmpty
--Determine if a table is empty.
---@param t table The table to find out whether or not it's empty.
---@return boolean result
return function(t)
    for _ in pairs(t) do return false end
    return true
end