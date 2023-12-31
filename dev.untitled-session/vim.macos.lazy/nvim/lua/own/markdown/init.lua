local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options

local utils = require("own.luautils")
local buffers = require("own.markdown.buffers")

local M = {
}

local config = {
  buffers = buffers.config
}

M.setup = function(config_options)
  if config_options ~= nil then
    for k, v in pairs(config_options) do
      config[k] = v
    end
  end
  utils.debug(string.format("buffers module: %s", buffers))
  utils.debug(string.format("buf.events: %s", vim.json.encode(buffers.events_values)))

  buffers.setup(config_options.buffers)

  vim.api.nvim_create_autocmd(
    {
      buffers.events.BufEnter,
      buffers.events.BufWritePre,
      buffers.events.BufLeave,
      buffers.events.BufWritePost,
    },
    {
      pattern={"*.md"},
      callback=function(ev)
        utils.debug(string.format("event arrived: %s", vim.inspect(ev)))
        -- handling event in buffer
        
      end
    }
  )
end

return M
