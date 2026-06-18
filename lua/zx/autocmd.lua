local basic = require("zx.basic")
local asm = require("zx.asm")
local config = require("zx.config")
local utils = require("zx.utils")

local M = {}

local function toggle_basic_comment()
	local row = vim.api.nvim_win_get_cursor(0)[1] - 1
	local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

	local num, code = line:match("^(%d+)%s+REM%s+(.*)$")
	if num then
		vim.api.nvim_buf_set_lines(
			0,
			row,
			row + 1,
			false,
			{ string.format("%s %s", num, code) }
		)
		return
	end

	num, code = line:match("^(%d+)%s+(.*)$")
	if num then
		vim.api.nvim_buf_set_lines(
			0,
			row,
			row + 1,
			false,
			{ string.format("%s REM %s", num, code) }
		)
	end
end


function M.setup()
	local opts = config.options
	----------------------------------------------------------------------
	-- BASIC filetype config
	----------------------------------------------------------------------
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "basic",

		callback = function(args)
			-- Local options
			vim.opt_local.expandtab = false
			vim.opt_local.tabstop = 8
			vim.opt_local.shiftwidth = 8
			vim.opt_local.number = false

			-- Auto increment line numbers
			local autoincrement = function(params)
				local newline = params.newline or false

				local line = vim.api.nvim_get_current_line()
				local num = line:match("^%s*(%d+)")

				if not num then
					return "\n"
				end

				local prev = tonumber(num)
				local step = 10

				return string.format(
					"%s\n%04d",
					newline and "\n" or "",
					prev + step
				)
			end

			-- Insert mode Enter
			vim.keymap.set(
				"i",
				"<CR>",
				function()
					return autoincrement({ newline = false })
				end,
				{
					buffer = args.buf,
					expr = true,
				}
			)

			-- Normal mode "o"
			vim.keymap.set(
				"n",
				"o",
				function()
					local text = autoincrement({ newline = true })
					local lines = {}

					for line in text:gmatch("([^\n]*)\n?") do
						if line ~= "" then
							table.insert(lines, line)
						end
					end

					vim.api.nvim_put(lines, "l", true, true)
					vim.cmd("startinsert!")
				end,
				{
					buffer = args.buf,
				}
			)

			-- Renumber lines
			vim.keymap.set(
				"n",
				opts.renumber_key,
				basic.renumber_lines,
				{
					buffer = args.buf,
					desc = "Re-number BASIC lines",
				}
			)

			-- Build
			vim.keymap.set(
				"n",
				opts.build_key,
				function()
					utils.maybe_save_before_build()
					basic.build()
				end, {
					buffer = args.buf,
					desc = "Build BASIC program",
				})

			-- Build + Run
			vim.keymap.set(
				"n",
				opts.run_key,
				function()
					utils.maybe_save_before_build()
					local build = basic.build()
					if build.code == 0 then
						basic.run()
					end
				end, {
					buffer = args.buf,
					desc = "Build and run BASIC program",
				})

			-- Clean
			vim.keymap.set(
				"n",
				opts.clean_key,
				"<cmd>ZXClean<cr>",
				{
					buffer = args.buf,
					desc = "Remove TAP/TZX files",
				}
			)
			vim.keymap.set("n", "gcc", toggle_basic_comment)
		end,
	})

	----------------------------------------------------------------------
	-- BASIC formatting before save
	----------------------------------------------------------------------
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.bas",

		callback = function()
			if not config.options.auto_renumber then
				return
			end

			local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
			for i, line in ipairs(lines) do
				lines[i] = line:gsub("^(%d+)%s*", "%1\t")
			end

			vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
			basic.renumber_lines()
		end,
	})

	----------------------------------------------------------------------
	-- Z80 filetype config
	----------------------------------------------------------------------
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "asm",
		callback = function(args)
			-- Local options
			vim.opt_local.number = true
			vim.opt_local.expandtab = false
			vim.opt_local.tabstop = 8
			vim.opt_local.shiftwidth = 8

			vim.keymap.set(
				"n",
				opts.clean_key,
				"<cmd>ZXClean<cr>",
				{
					buffer = args.buf,
					desc = "Remove TAP/TZX files",
				}
			)

			-- Build
			vim.keymap.set(
				"n",
				opts.build_key,
				function()
					utils.maybe_save_before_build()
					asm.build()
				end,
				{
					buffer = args.buf,
					desc = "Assemble Z80 source",
				}
			)

			-- Build + Run
			vim.keymap.set(
				"n",
				opts.run_key,
				function()
					utils.maybe_save_before_build()
					local build = asm.build()
					if build.code == 0 then
						asm.run()
					end
				end,
				{
					buffer = args.buf,
					desc = "Assemble and run Z80 program",
				}
			)
		end,
	})
end

return M
