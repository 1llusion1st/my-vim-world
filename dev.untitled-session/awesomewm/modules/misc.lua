local M = {}

function M.scandir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a '..directory)
    -- naughty.notify({text = (string.format('pfile : %s', type(pfile)))})
    if pfile == nil then return t end
    for filename in pfile:lines() do
        if filename ~= "." and filename ~= ".." then
            i = i + 1
            t[i] = filename
        end
    end
    pfile:close()
    return t
end

function M.expanduser(P)
    if P:sub(1,1) == '~' then
        local home = os.getenv('HOME')
        if not home then -- has to be Windows
            home = os.getenv 'USERPROFILE' or (os.getenv 'HOMEDRIVE' .. os.getenv 'HOMEPATH')
        end
        return home..P:sub(2)
    else
        return P
    end
end

return M
