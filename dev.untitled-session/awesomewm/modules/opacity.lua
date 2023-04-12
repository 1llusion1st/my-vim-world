local M = {}

local beautiful = require("beautiful")

local opacity_manual = {}
local def_in_opacity = 1
local def_out_opacity = 0.9
local opacity_step = 0.05

local opacity_out_map_by_class = {}
opacity_out_map_by_class['Brave-browser'] = 0.6
opacity_out_map_by_class['Gnome-terminal'] = 0.7

local opacity_in_map_by_class = {}
opacity_in_map_by_class['Brave-browser'] = 0.95
opacity_in_map_by_class['Gnome-terminal'] = 0.85


function M.init_opacity_manager()
    --{{{ Setup transparency composer
    io.popen "xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 &"
    --}}}
end

local function normalize_opacity(opacity)
    if opacity < 0 then return 0.0 end
    if opacity > 1.0 then return 1.0 end
    return opacity
end


local function get_in_opacity(c)
    return opacity_manual[c.window] or opacity_in_map_by_class[c.class] or def_in_opacity
end

local function get_out_opacity(c)
    -- naughty.notify({text = "client: "..type(c)})
    if opacity_manual[c.window] ~= nil then
        return normalize_opacity(opacity_manual[c.window] - opacity_step)
    end
    return opacity_out_map_by_class[c.class] or def_out_opacity
end

local function save_opacity(c, opacity)
    opacity_manual[c.window] = opacity
    c.opacity = opacity
end

function M.increase_opacity(c)
    local opacity = get_in_opacity(c)
    save_opacity(c, normalize_opacity(opacity + opacity_step))
end

function M.decrease_opacity(c)
    local opacity = get_in_opacity(c)
    save_opacity(c, normalize_opacity(opacity - opacity_step))
end

function M.setup_opacity(client)

    client.connect_signal("focus", function(c)
        c.border_color = beautiful.border_focus
        c.opacity=get_in_opacity(c)
        -- naughty.notify({text="c.name:"..c.name.." type:"..c.type.." class:"..c.class.." opacity: "..string.format("%f", c.opacity)})
    end)
    client.connect_signal("unfocus", function(c)
        c.border_color = beautiful.border_normal
        c.opacity=get_out_opacity(c)
    end)
end

return M
