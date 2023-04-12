local M = {}

function M.suppress_display_offline()
    io.popen "xset s off; xset -dpms; xset s noblank"
end

return M
