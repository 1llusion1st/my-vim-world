local M = {}

local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")

local l_misc = require "modules/misc"

local function get_wallpaper(s)
    local dir = "~/Downloads/wallpapers"
    local files = l_misc.scandir(dir)
    -- naughty.notify({text = (string.format('files len: %s', #files))})
    if #files > 0 then
        return l_misc.expanduser(dir.."/"..files[math.random(1, #files)])
    end
    return ""
end

local function set_wallpaper(s)
    -- Wallpaper
    -- naughty.notify({text="set_wallpaper called"})
    local wallpaper = get_wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
        -- naughty.notify({text="converting"})
        wallpaper = wallpaper(s)
    end

    if wallpaper ~= "" then
        -- naughty.notify({text = ('setting wallpaper: '..wallpaper)})
        gears.wallpaper.maximized(wallpaper, s, true)

    end
end

M.set_wallpaper = set_wallpaper

function M.init_wallpaper(screen)
	screen.connect_signal("property::geometry", set_wallpaper)
end

return M
