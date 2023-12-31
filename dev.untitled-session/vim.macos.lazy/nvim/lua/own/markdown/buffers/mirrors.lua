local M = {}

local utils = require("own.luautils")
local constants = require("own.markdown.buffers.constants")
--[=====[ 

--]=====]


local Mirror = {
  bufnr=nil,
  destbufnr=nil
}

function Mirror:new(bufnr, destbufnr)
  local obj = utils.deepcopy(Mirror)
  setmetatable(obj, Mirror)
  obj.bufnr = bufnr
  obj.destbufnr = destbufnr
end

M.new = Mirror.new

local mirrors = {}

function mirrors:new(bufnr)
  -- algo --
  -- create new buffer
  -- set buffer autocmd for write post
  -- save link
  -- navigate to buffer ???

end

function mirrors:process_event(e)
  local handler = mirrors[e.buf]
  if handler == nil then return end
end

function mirrors:process_event_md(e)
end

function mirrors:process_event_from_buffer(e)
end

-- // load mirrors from home dir ?
function mirrors:load()
end

local editor_mirrors = utils.deepcopy(mirrors)
setmetatable(editor_mirrors, mirrors)
editor_mirrors.load()

return M
