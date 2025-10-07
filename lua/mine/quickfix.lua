-- quick fix better defaults
function deleteItemsQF()
	local items = vim.fn.getqflist()
	local line = vim.fn.line(".")
	table.remove(items, line)
	vim.fn.setqflist(items, "r")
	vim.api.nvim_win_set_cursor(0, { line, 0 })
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR><C-w>j", true, true, true), "n", true)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "j", "j<CR><C-w>j", { buffer = 0, noremap = true, silent = true })
		vim.keymap.set("n", "k", "k<CR><C-w>j", { buffer = 0, noremap = true, silent = true })
		vim.keymap.set("n", "J", "5j<CR><C-w>j", { buffer = 0, noremap = true, silent = true })
		vim.keymap.set("n", "K", "5k<CR><C-w>j", { buffer = 0, noremap = true, silent = true })
		vim.keymap.set("n", "D", deleteItemsQF, { buffer = 0, noremap = true })
	end,
})
