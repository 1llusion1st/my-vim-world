print("my dummy plugin load started")

local constants = require("luaPlugin.constants")

local function test_function()
	print("call from test function")
end

local function get_edited_file()
	local file = vim.fn.expand("%:p")
	return file
end

print("my dummy plugin load ended")

return {
	test_function = test_function,
	get_edited_file = get_edited_file,
	show_constant = function()
		print("constant = " .. constants.a)
	end,
	C = 10,
	ask_question = function()
	end
}
