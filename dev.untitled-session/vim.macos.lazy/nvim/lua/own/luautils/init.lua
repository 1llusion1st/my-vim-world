local M = {}

local config = {
  debug = false
}

M.debug_enable = function ()
  config.debug = true
end

M.debug_disable = function ()
  config.debug = false
end

M.debug = function(msg)
  if config.debug then
    print(msg)
  end
end

M.setup = function(config_options)
  if config_options ~= nil then
    for k, v in pairs(config_options) do
      config[k] = v
    end
  end
  M.debug(string.format("input config: %s state config: %s", vim.json.encode(config_options), vim.json.encode(config)))
end

local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

M.deepcopy = deepcopy

local function get_fullpath_by_bufnr(bufferNumber)
  if vim.fn.bufexists(bufferNumber) == 0 then
      return nil
  end

  local bufferName = vim.fn.bufname(bufferNumber)

  if bufferName == '' then
      return nil
  end

  local fullPath = vim.fn.fnamemodify(bufferName, ':p')

  return fullPath
end

M.get_fullpath_by_bufnr = get_fullpath_by_bufnr


local function get_extension_by_bufnr(buf)
  local current_file = get_fullpath_by_bufnr(buf)
  if current_file == nil then return nil end
  local _, _, extension = current_file:match("(.+)/([^/]+)%.(.+)")
  return extension
end



M.get_extension_by_bufnr = get_extension_by_bufnr

return M
