-----------------------------------------------suggestion setup--------------------------------------------------
function suggestion_setup()
	-- cmp
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	vim.lsp.config("*", {
		capabilities = capabilities,
		root_markers = { ".git" },
	})

	local ls = require("luasnip")

	require("luasnip.loaders.from_vscode").lazy_load()

	local cmp = require("cmp")

	cmp.setup({
		preselect = cmp.PreselectMode.None,
		snippet = {
			expand = function(args)
				ls.lsp_expand(args.body)
			end,
		},
		mapping = {
			["<Tab>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
			["<C-Space>"] = function()
				if ls.jumpable(1) then
					-- jump next arg
					ls.expand_or_jump()
				else
					if cmp.visible() then
						-- disable
						cmp.abort()
					else
						-- show completion
						cmp.complete()
					end
				end
			end,
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-p>"] = cmp.mapping.select_prev_item(),
		},
		window = {
			completion = cmp.config.window.bordered({
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			}),
			documentation = cmp.config.window.bordered({
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			}),
		},
		performance = {
			debounce = 60,
			throttle = 30,
			fetching_timeout = 200,
			max_view_entries = 4,
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "buffer" },
		}),
	})

	require("lsp_signature").setup({
		floating_window = true,
		floating_window_above_cur_line = true,
		max_height = 3,
		hint_enable = false,
	})
end
