local M = {}

M.options = {
	save_before_compile = true,
	emulator = "fbzx",
	window_name = "FBZX",
	basic_auto_renumber = true,
	basic_compiler = "zmakebas",
	basic_vim_commentary_disabled = true,
	basic_line_increment = 10,
	assembler = "sjasmplus",
	build_key = "<leader>b",
	run_key = "<leader>r",
	comment_key = "<leader>c",
	clean_key = "<leader>x",
	renumber_key = "<leader>n",
	emulator_opts = {
		-- temporary hook after running emulator
		-- my hack with xdotool
		hook = false,
		nosound = false,
	}
}

function M.setup(opts)
	M.options = vim.tbl_deep_extend(
		"force",
		M.options,
		opts or {}
	)
end

return M
