local function hi(group, gui, cterm, opts)
	opts = opts or {}
	vim.cmd(string.format(
		"highlight %s guifg=%s ctermfg=%d%s%s",
		group,
		gui,
		cterm,
		opts.italic and " gui=italic" or "",
		opts.italic and " cterm=italic" or ""
	))
end

hi("zxbComment", "#666666", 244, { italic = true })
hi("zxbLineNumber", "#505050", 239)
hi("zxbGraphics", "#61afef", 75)
hi("zxbColour", "#c678dd", 176)
