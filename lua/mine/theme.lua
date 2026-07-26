-- ----------------------------------------lualine--------------------------------------------------
local function lualine_setup()
	local theme = vim.o.background == "dark" and "iceberg_dark" or "iceberg_light"

	require("lualine").setup({
		options = {
			theme = theme,
			component_separators = "",
			section_separators = "",
			refresh = {
				statusline = 10,
			},
		},
		sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				"filename",
			},
			lualine_x = {},
			lualine_y = {
				{
					"diagnostics",
					update_in_insert = false,
					symbols = {
						error = "████████",
					},
				},
				"filetype",
			},
			lualine_z = {},
		},
	})
end

		end
		end

vim.keymap.set("n", "<leader>=", function()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
	vim.cmd.colorscheme("vscode")
end)

vim.opt.fillchars:append({ diff = "·" })
require("solarized").setup({
	variant = "autumn",
	styles = {
		enabled = true,
		comments = { bold = true, italic = true },
	},
	plugins = {
		treesitter = true,
		lspconfig = false,
	},
	on_highlights = function(colors, color)
		local darken = color.darken
		local blend = color.blend

		return {
			["@variable.parameter"] = { fg = colors.base0, italic = false },
			["@lsp.type.parameter"] = { fg = colors.base0, italic = false },

			DiffAdd = { bg = blend(colors.green, colors.base3, 0.25), fg = colors.base00 },
			DiffDelete = { bg = blend(colors.red, colors.base3, 0.25), fg = colors.base1, strikethrough = false },
			DiffChange = { bg = blend(colors.yellow, colors.base3, 0.20), fg = colors.base00 },
			DiffText = { bg = blend(colors.blue, colors.base3, 0.40), fg = colors.base03, bold = true },
		}
	end,
})

vim.o.background = "light"
vim.cmd.colorscheme("solarized")
