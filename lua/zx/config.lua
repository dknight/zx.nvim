local M = {}

M.options = {
	save_before_compile = true,
	auto_renumber = true,
	emulator = "fbzx",
	window_name = "FBZX",
	basic_compiler = "zmakebas",
	assembler = "sjasmplus",
	build_key = "<leader>b",
	run_key = "<leader>r",
	comment_key = "<leader>c",
	clean_key = "<leader>x",
	renumber_key = "<leader>n",
	-- temporary hook after running emulator
	-- my hack with xdotool
	emu_hook = false,
}

function M.setup(opts)
	M.options = vim.tbl_deep_extend(
		"force",
		M.options,
		opts or {}
	)
end

return M
