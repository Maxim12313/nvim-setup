function conform_setup()
	local conform = require("conform")
	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			python = { "ruff_format" },
			rust = { "rustfmt" },
			go = { "gofmt" },
			bash = { "shfmt" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	})

	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

	vim.api.nvim_set_keymap("n", "==", "gqq", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("v", "=", "gq", { noremap = true, silent = true })
end
