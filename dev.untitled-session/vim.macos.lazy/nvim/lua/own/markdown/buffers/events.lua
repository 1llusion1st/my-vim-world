local M = {}

M.events = {
  BufEnter = "BufEnter",
  BufLeave = "BufLeave",
  BufWinEnter = "BufWinEnter",
  BufWinLeave = "BufWinLeave",
  BufWrite = "BufWrite",
  BufWritePre = "BufWritePre",
  BufWritePost = "BufWritePost",
}

M.events_values = {}

for _, v in pairs(M.events) do
  table.insert(M.events_values, v)
end

return M
