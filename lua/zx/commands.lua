local M = {}

local basic = require("zx.basic")
local asm = require("zx.asm")
local utils = require("zx.utils")

function M.setup()
	vim.api.nvim_create_user_command("ZXBuild", function()
		local ft = vim.bo.filetype

		utils.maybe_save_before_build()

		if ft == "basic" then
			basic.build()
		elseif ft == "asm" then
			asm.build()
		else
			vim.notify(
				"Unsupported filetype: " .. ft,
				vim.log.levels.ERROR
			)
		end
	end, {})

	vim.api.nvim_create_user_command("ZXRun", function()
		local ft = vim.bo.filetype

		utils.maybe_save_before_build()

		if ft == "basic" then
			local build = basic.build()
			if build.code == 0 then
				basic.run()
			end
		elseif ft == "asm" then
			local build = asm.build()
			if build.code == 0 then
				asm.run()
			end
		else
			vim.notify(
				"Unsupported filetype: " .. ft,
				vim.log.levels.ERROR
			)
		end
	end, {})

	vim.api.nvim_create_user_command("ZXClean", function()
		local files = vim.fn.glob("*.tap", false, true)

		vim.list_extend(
			files,
			vim.fn.glob("*.tzx", false, true)
		)

		for _, file in ipairs(files) do
			vim.fn.delete(file)
		end

		vim.notify(
			string.format("Removed %d file(s)", #files)
		)
	end, {
		desc = "Remove TAP and TZX files",
	})

	vim.api.nvim_create_user_command("ZXRenumber", function()
		local ft = vim.bo.filetype
		if ft == "basic" then
			basic.renumber_lines()
		end
	end, {
		desc = "Renumber BASIC lines"
	})
end

return M
