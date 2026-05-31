--------------------------------------------------------------------------
-- ZX Spectrum ASM
--------------------------------------------------------------------------
local config = require("zx.config")
local utils = require("zx.utils")

local M = {}

function M.build()
	local opts = config.options

	if not utils.check_executable(opts.assembler) then
		return { code = 1 }
	end

	return vim.system({
		opts.assembler,
		vim.fn.expand("%"),
	}):wait()
end

function M.run()
	local opts = config.options

	if not utils.check_executable(opts.emulator) then
		return
	end

	local tap = vim.fn.expand("%:r") .. ".tap"

	if vim.fn.filereadable(tap) == 0 then
		vim.notify(
			"TAP file not found: " .. tap,
			vim.log.levels.ERROR
		)
		return
	end

	vim.system({
		opts.emulator,
		vim.fn.expand("%:r") .. ".tap",
	}, {
		detach = true,
	})
end

return M
