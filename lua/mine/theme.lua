-- change theme light/dark
------------------------------------------lualine--------------------------------------------------
function lualine_setup()
	local theme
	if vim.o.background == "dark" then
		theme = "iceberg_dark"
	else
		theme = "iceberg_light"
	end

	require("lualine").setup({
		options = {
			theme = theme,
			component_separators = "",
			section_separators = "",
		},
		sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				"filename",
				-- { "filename", path = 1 },
			},
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_lsp" },
				},
			},
			lualine_y = {
				"filetype",
			},
			lualine_z = {},
		},
	})
end

--------------------------------- overrides ---------------------------------
local function hl_exists(group)
	return pcall(vim.api.nvim_get_hl, 0, { name = group })
end

local function setBG(group, bg_color)
	if not hl_exists(group) then
		return
	end
	local current_hl = vim.api.nvim_get_hl_by_name(group, true)
	local fg_color = current_hl.foreground or "NONE"
	vim.api.nvim_set_hl(0, group, { fg = fg_color, bg = bg_color })
end

local function dark()
	setBG("TreesitterContextBottom", "#203034")
	vim.api.nvim_set_hl(0, "Visual", { bg = "#335E5E", blend = 80 })
	vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#335E5E", blend = 80 })

	local normal = "#212229"
	-- setBG("Normal", normal)

	local line = "#30313b"
	setBG("CursorLine", line)
	setBG("CursorLineNr", line)

	-- set comment
	local col = "#34C22C"
	-- local col = "#6A737D"
	-- local col = "#5C6370"

	vim.api.nvim_set_hl(0, "Comment", { bg = nil, fg = col })
	-- vim.api.nvim_set_hl(0, "MatchParen", { fg = "#FFD700", bg = "#282a36", bold = true })
	vim.api.nvim_set_hl(0, "MatchParen", { fg = "#CC241D", bg = "#282a36", bold = true })

	vim.api.nvim_set_hl(0, "Identifier", { fg = "#999999" })

	vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", { fg = "#FF66CC" })

	vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#2c3e26", fg = "none" }) -- Subtle dark olive green
	vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#492324", fg = "#75715e" }) -- Subtle dark wine red / Muted gray text
	vim.api.nvim_set_hl(0, "DiffChange", { bg = "#233745", fg = "none" }) -- Subtle dark navy blue
	vim.api.nvim_set_hl(0, "DiffText", { bg = "#1d4f73", fg = "none", bold = true, underline = true }) -- Intenser blue + Bold & Underlined words
end

local function light()
	setBG("TreesitterContextBottom", "#dce0e8")
	vim.api.nvim_set_hl(0, "MatchParen", {
		fg = "#FFFFFF",
		bg = "#FFD700",
		bold = true,
	})

	-- local normal = "#F2EEDE"
	local normal = "#eff1f5"
	-- local normal = "#FFFFFF"
	-- local normal = "#fdf6e3"
	vim.api.nvim_set_hl(0, "Normal", { fg = "#000000", bg = normal, blend = 80 })

	vim.api.nvim_set_hl(0, "Visual", { bg = "#D0D0D0", blend = 30 })
	vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#D0D0D0", blend = 30 })

	-- local line = "#FFF4D6"
	local line = "#e6e9ef"
	setBG("CursorLine", line)
	setBG("CursorLineNr", line)

	-- set comment
	-- local col = "#D2691E"
	-- local col = "#34C22C"
	local col = "#6A9955"
	vim.api.nvim_set_hl(0, "Comment", { bg = nil, fg = col })

	-- member vars etc
	vim.api.nvim_set_hl(0, "Identifier", { fg = "#777777" })

	-- types
	vim.api.nvim_set_hl(0, "Keyword", { fg = "#007373" })
	vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", { fg = "#CC52A3" })

	vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#cce8cc", fg = "#155724" }) -- Richer mint green background + Dark green text
	vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#f8d7da", fg = "#721c24" }) -- Saturated rose background + Dark crimson text
	vim.api.nvim_set_hl(0, "DiffChange", { bg = "#e2e3e5", fg = "#383d41" }) -- Noticeable steel gray background + Dark charcoal text
	vim.api.nvim_set_hl(0, "DiffText", { bg = "#b8daff", fg = "#004085", bold = true, underline = true }) -- Vivid sky blue + Deep navy text + Bold/Underline
end

local function clean_groups()
	for _, group in ipairs(vim.fn.getcompletion("", "highlight")) do
		local hl = vim.api.nvim_get_hl_by_name(group, true)
		if hl then
			-- no decoration
			hl.italic = nil
			hl.bold = nil
			hl.underline = nil

			vim.api.nvim_set_hl(0, group, hl)
		end
	end
end

local function link_groups(match, other)
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			for _, group in ipairs(vim.fn.getcompletion(match, "highlight")) do
				vim.api.nvim_set_hl(0, group, { link = other, force = true })
			end
		end,
	})
end

local function link_treesitter_groups()
	link_groups("@variable", "Normal")
	link_groups("@comment", "Comment")
	link_groups("@keyword", "Keyword")
end

function adjust_colors()
	print("ran")
	if vim.o.background == "dark" then
		dark()
	else
		light()
	end

	clean_groups()
	lualine_setup()
	link_treesitter_groups()

	local normal_fg = vim.api.nvim_get_hl_by_name("Normal", true).foreground
	vim.api.nvim_set_hl(0, "Function", { fg = normal_fg })

	setBG("EndOfBuffer", nil)
	setBG("SignColumn", nil)
	setBG("LineNr", nil)
	setBG("NormalNC", nil)
	vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = nil, fg = "#ff5f5f" })
	vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = nil, fg = "#e0af00" })
	setBG("DiagnosticSignInfo", nil)
	setBG("DiagnosticSignHint", nil)
	setBG("NormalFloat", nil)

	vim.api.nvim_set_hl(0, "Search", { bg = "#FFD700", fg = "#000000", bold = true }) -- Normal search highlight
	vim.api.nvim_set_hl(0, "IncSearch", { bg = "#ffb86c", fg = "#282a36", bold = true }) -- While typing in search mode

	-- set cursor to default terminal
	vim.cmd("highlight Cursor guifg=NONE guibg=NONE")
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

vim.api.nvim_create_autocmd({ "Colorscheme" }, {
	callback = adjust_colors,
})

vim.keymap.set("n", "<leader>=", function()
	if vim.o.background == "dark" then
		vim.o.background = "light"
		vim.cmd.colorscheme("vscode")
	else
		vim.o.background = "dark"
		vim.cmd.colorscheme("vscode")
	end
end)

-- require("solarized").setup({
-- 	plugins = {
-- 		telescope = false,
-- 	},
-- })

vim.o.background = "light"
vim.cmd.colorscheme("vscode")
