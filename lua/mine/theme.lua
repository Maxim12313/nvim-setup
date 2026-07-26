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

local function setup_native_statusline()
	local function get_diagnostics()
		if not vim.diagnostic.is_enabled() then
			return ""
		end

		local counts = vim.diagnostic.count(0)
		local err_count = counts[vim.diagnostic.severity.ERROR] or 0

		if err_count > 0 then
			-- Uses native DiagnosticError highlight group from solarized
			return string.format("%%#DiagnosticError#█████████████(%d)%%*", err_count)
		end
		return ""
	end

	-- Assemble statusline segments dynamically
	_G.custom_statusline = function()
		local is_focused = (vim.g.statusline_winid == vim.api.nvim_get_current_win())

		local file_name = "%f %m%r"
		local diag = is_focused and get_diagnostics() or ""
		local filetype = is_focused and "%Y" or ""

		-- Combine left (c) and right (y) sections separated by %= (pushes rest to right side)
		return string.format(" %s  %%= %s %s ", file_name, diag, filetype)
	end

	-- Apply custom statusline to Neovim
	vim.opt.statusline = "%!v:lua.custom_statusline()"
	vim.opt.laststatus = 2
end

setup_native_statusline()

vim.keymap.set("n", "<leader>=", function()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
	vim.cmd.colorscheme("solarized")
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
