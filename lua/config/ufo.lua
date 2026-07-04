function ufo_setup()
	local ufo = require("ufo")

	vim.o.foldcolumn = "0"
	vim.o.foldlevel = 99
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true

	ufo.setup({
		provider_selector = function(bufnr, filetype, buftype)
			return { "treesitter", "indent" }
		end,
		open_fold_hl_timeout = 0,
		mappings = {},
	})

	vim.keymap.set("n", "+", "za", { desc = "Toggle fold" })
	vim.keymap.set("n", "zj", function()
		ufo.goNextClosedFold()
	end, { desc = "Go to next closed fold" })
	vim.keymap.set("n", "zk", function()
		ufo.goPreviousClosedFold()
	end, { desc = "Go to previous closed fold" })
end
