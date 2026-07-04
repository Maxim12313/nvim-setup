function ufo_init()
	vim.o.foldcolumn = "0"
	vim.o.foldlevel = 99
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true
end

function ufo_setup()
	local ufo = require("ufo")

	ufo.setup({
		provider_selector = function(bufnr, filetype, buftype)
			return { "treesitter" }
		end,
		open_fold_hl_timeout = 0,
		mappings = {},
	})

	vim.keymap.set("n", "+", "za", { desc = "Toggle fold" })
	vim.keymap.set("n", "zR", require("ufo").openAllFolds)
	vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
	vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
	vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
end
