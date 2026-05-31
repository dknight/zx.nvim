local config = require("zx.config")

local M = {}

function M.maybe_save_before_build()
	if config.options.save_before_compile then
		vim.cmd("w")
	end
end

function M.check_executable(executable)
	if vim.fn.executable(executable) == 0 then
		vim.notify(
			string.format(
				'Executable "%s" not found in PATH',
				executable
			),
			vim.log.levels.ERROR
		)

		return false
	end

	return true
end

return M
