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
            return frame:preprocess([===[{{FrameWithHeader|color=7289DA|header = '''✔This user is verified✔'''|content = This user is a verified '''[[Community:Staff|Discord staff member]]'''.}}]===])
            
            end
        end
        return ""
    end
return p