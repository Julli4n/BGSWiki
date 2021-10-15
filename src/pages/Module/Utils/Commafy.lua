---@class Commafy
--Add commas to a number after being converted to a string
--
--Use `mw.language:formatNum` instead
---@deprecated
---@param str string | number String to add commas to.
---@return string stringWithCommas String with commas.
function commafy(str)
    str = tostring(str)
    return #str % 3 == 0 and str:reverse():gsub("(%d%d%d)", "%1,"):reverse():sub(2) or str:reverse():gsub("(%d%d%d)", "%1,"):reverse()
end

return commafy