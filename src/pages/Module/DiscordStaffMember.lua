local p = {}
local DiscordStaff = {
    'Bawp29',
    'IAmaPersonthatExists',
    'Mr.Bladen',
    'DatBoiAJ'
}
function p.Verify(frame)
    for _,v in pairs(DiscordStaff) do
        if v == frame:preprocess('{{PAGENAME}}') and frame:preprocess('{{NAMESPACE}}') == 'User' then
            return frame:preprocess([===[{{Frame|color=7289DA|content=<div style="border-bottom:0.1px solid #a6a6a6"><big>'''✔This user is verified✔'''</big></div>This is a verified '''[[Community:Staff|Discord staff member]]'''.}}]===])
            
            end
        end
        return ""
    end
return p