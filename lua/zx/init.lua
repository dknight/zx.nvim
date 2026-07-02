local M = {}

local initialized = false

function M.setup(opts)
	if initialized then
		return
	end
	require("zx.config").setup(opts)
	require("zx.autocmd").setup()
	require("zx.commands").setup()
	require("zx.highlight")
	initialized = true
end

return M
