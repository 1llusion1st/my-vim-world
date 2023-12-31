local M = {}

local mirrors = require("own.markdown.buffers.mirrors")
local be = require("own.markdown.buffers.events")
local config = require("own.markdown.buffers.config")
local constants = require("own.markdown.buffers.constants")

M.events = be.events
M.events_values = be.events_values
M.mirrors = mirrors
M.config = config
M.constants = constants

M.setup = function (conf_update)
  if conf_update == nil then return end
  for k, v in pairs(conf_update) do
    M.config[k] = v
  end
end

return M
