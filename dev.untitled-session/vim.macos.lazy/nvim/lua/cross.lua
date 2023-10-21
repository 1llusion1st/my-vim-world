local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options

local function create_crossfile_func(handlers)
  return function ()
    local handler = handlers[vim.bo.filetype]
    if handler == nil then
      handler = handlers["default"]
    end
    if handler == nil then return end

    if type(handler) == "string" then
      vim.cmd(handler)
      return
    end

    local current_file = vim.fn.expand("%:p")
    -- Extract the base filename and extension
    local path, base_filename, extension = current_file:match("(.+)/([^/]+)%.(.+)")
    handler({
      current_file = current_file,
      path = path,
      base_filename = base_filename,
      extension = extension,
      filename = base_filename .. "." .. extension
    })
  end
end

-- cross
function Alternative()
  if vim.bo.filetype == "go" then
    vim.cmd("GoAlt")
  else
  local current_file = vim.fn.expand("%:p")
  -- Extract the base filename and extension
  local path, base_filename, extension = current_file:match("(.+)/([^/]+)%.(.+)")
  if not base_filename or not extension then
    print("Cannot determine the file extension.")
    return
  end
  local target_file = ""
  if base_filename:sub(-5) == "_test" then
    base_filename = base_filename:sub(1, -6)  -- Remove "_test" suffix
    target_file = base_filename .. "." .. extension
  else
    target_file = base_filename .. "_test." .. extension
  end

  if path ~= "" then
    target_file = path .. "/" .. target_file
  end
  print("target_file: " .. target_file)
  vim.cmd("edit " .. target_file)
  end
end

vim.keymap.set("n", "ga", ":lua Alternative()<CR>", {})

-- cross test

RunTestFuncTiny = create_crossfile_func({
  go = "GoTestFunc",
  python = "Pytest file",
})

RunTestFuncVerbose = create_crossfile_func({
  go = "GoTestFunc -vF -count=1",
  python = "Pytest file verbose",
})

vim.keymap.set("n", "tf", ":lua RunTestFuncTiny()<CR>", {})
vim.keymap.set("n", "tF", ":lua RunTestFuncVerbose()<CR>", {})

