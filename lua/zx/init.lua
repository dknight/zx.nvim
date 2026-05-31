local M = {}

local initialized = false

function M.setup(opts)
	if initialized then
		return
	end
	require("zx.config").setup(opts)
	require("zx.autocmd").setup()
	require("zx.commands").setup()
	initialized = true
end

return M
