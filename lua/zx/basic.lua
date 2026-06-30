--------------------------------------------------------------------------
-- ZX Spectrum (BASIC)
--------------------------------------------------------------------------
local config = require("zx.config")
local utils = require("zx.utils")

local M = {}

--------------------------------------------------------------------------
-- BASIC helpers
--------------------------------------------------------------------------
function M.get_bas_file()
	return vim.api.nvim_buf_get_name(0)
end

function M.get_tap_file()
	return M.get_bas_file():gsub("%.bas$", ".tap")
end

function M.build()
	local opts = config.options

	if not utils.check_executable(opts.basic_compiler) then
		return { code = 1 }
	end

	local build = vim.system(
		{
			opts.basic_compiler,
			"-o",
			M.get_tap_file(),
			M.get_bas_file(),
		},
		{ text = true }
	):wait()

	if build.code ~= 0 then
		vim.notify(build.stderr, vim.log.levels.ERROR)
	else
		vim.notify(M.get_tap_file() .. " build successful")
	end

	return build
end

function M.run()
	local opts = config.options

	if not utils.check_executable(opts.emulator) then
		return
	end

	vim.notify("Emulation running...")

	-- FIXME kinda hack just for me remove later
	if opts.emu_hook then
		vim.system({
			"sh",
			"-c",
			string.format([[
%s -nosound "%s" &
sleep 3
xdotool search --name "%s" | tail -n1 | xargs xdotool windowactivate
sleep 0.2
xdotool key j
sleep 0.2
xdotool keydown Control_L
xdotool key p
xdotool keyup Control_L
sleep 0.1
xdotool keydown Control_L
xdotool key p
xdotool keyup Control_L
sleep 0.2
xdotool key Return
sleep 0.2
xdotool key r
xdotool key Return
        ]], opts.emulator, M.get_tap_file(), opts.window_name),
		}, {
			detach = true,
		})
	else
		vim.system({
				opts.emulator,
				M.get_tap_file(),
			},
			{
				detach = true,
			})
	end
end

function M.renumber_lines()
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	local new_lines = {}

	local step = 10
	local number = 10

	for _, line in ipairs(lines) do
		local skip_line = line:match("^%s*$")
			or line:match("^%s*[Rr][Ee][Mm]%f[%W]")

		if skip_line then
			table.insert(new_lines, line)
		else
			local old_num, rest = line:match("^%s*(%d+)(.*)$")
			old_num = tonumber(old_num)

			if old_num then
				if old_num == number then
					table.insert(
						new_lines,
						string.format("%04d %s", old_num, rest)
					)

					number = number + step
				elseif old_num > (number - step) and old_num < number then
					table.insert(
						new_lines,
						string.format("%04d %s", old_num, rest)
					)
				else
					table.insert(
						new_lines,
						string.format("%04d %s", number, rest)
					)

					number = number + step
				end
			else
				table.insert(
					new_lines,
					string.format("%04d %s", number, line)
				)

				number = number + step
			end
		end
	end

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
end

return M
