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
				{
					"diagnostics",
					update_in_insert = false,
					symbols = {
						error = "████████",
					},
				},
			},
			lualine_x = {},
			lualine_y = { "filetype" },
			lualine_z = {},
		},
	})
end

-- --------------------------------- overrides ---------------------------------
local function hl_exists(group)
	local hl = vim.api.nvim_get_hl(0, { name = group })
	return next(hl) ~= nil
end

local function setBG(group, bg_color)
	if not hl_exists(group) then
		return
	end
	local current_hl = vim.api.nvim_get_hl(0, { name = group, link = false })
	local fg_color = current_hl.fg or "NONE"
	vim.api.nvim_set_hl(0, group, { fg = fg_color, bg = bg_color })
end

local function dark()
	setBG("TreesitterContextBottom", "#203034")
	vim.api.nvim_set_hl(0, "Visual", { bg = "#335E5E", blend = 80 })
	vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#335E5E", blend = 80 })

	local line = "#30313b"
	setBG("CursorLine", line)
	setBG("CursorLineNr", line)

	vim.api.nvim_set_hl(0, "Comment", { bg = nil, fg = "#34C22C" })
	vim.api.nvim_set_hl(0, "MatchParen", { fg = "#CC241D", bg = "#282a36", bold = true })
	vim.api.nvim_set_hl(0, "Identifier", { fg = "#999999" })
	vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", { fg = "#FF66CC" })

	vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#2c3e26", fg = "none" })
	vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#492324", fg = "#75715e" })
	vim.api.nvim_set_hl(0, "DiffChange", { bg = "#233745", fg = "none" })
	vim.api.nvim_set_hl(0, "DiffText", { bg = "#1d4f73", fg = "none", bold = true, underline = true })
end

local function light()
	setBG("TreesitterContextBottom", "#dce0e8")
	vim.api.nvim_set_hl(0, "MatchParen", { fg = "#FFFFFF", bg = "#FFD700", bold = true })
	vim.api.nvim_set_hl(0, "Normal", { fg = "#000000", bg = "#eff1f5", blend = 80 })
	vim.api.nvim_set_hl(0, "Visual", { bg = "#D0D0D0", blend = 30 })
	vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#D0D0D0", blend = 30 })

	local line = "#e6e9ef"
	setBG("CursorLine", line)
	setBG("CursorLineNr", line)

	vim.api.nvim_set_hl(0, "Comment", { bg = nil, fg = "#6A9955" })
	vim.api.nvim_set_hl(0, "Identifier", { fg = "#777777" })
	vim.api.nvim_set_hl(0, "Keyword", { fg = "#007373" })
	vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", { fg = "#CC52A3" })

	setBG("DiffAdd", "#cce8cc")
	setBG("DiffDelete", "#f8d7da")
	setBG("DiffChange", "#e2e3e5")
	setBG("DiffText", "#b8daff")
end

local function clean_groups()
	for _, group in ipairs(vim.fn.getcompletion("", "highlight")) do
		local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
		if hl and next(hl) ~= nil then
			hl.italic = nil
			hl.bold = nil
			hl.underline = nil
			vim.api.nvim_set_hl(0, group, hl)
		end
	end
end

local function link_groups(match, other)
	for _, group in ipairs(vim.fn.getcompletion(match, "highlight")) do
		vim.api.nvim_set_hl(0, group, { link = other, force = true })
	end
end

local function link_treesitter_groups()
	link_groups("@variable", "Normal")
	link_groups("@comment", "Comment")
	link_groups("@keyword", "Keyword")
end

function adjust_colors()
	if vim.o.background == "dark" then
		dark()
	else
		light()
	end

	clean_groups()
	lualine_setup()
	link_treesitter_groups()

	local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
	local normal_fg = normal_hl.fg or "NONE"
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

	vim.api.nvim_set_hl(0, "Search", { bg = "#FFD700", fg = "#000000", bold = true })
	vim.api.nvim_set_hl(0, "IncSearch", { bg = "#ffb86c", fg = "#282a36", bold = true })

	vim.cmd("highlight Cursor guifg=NONE guibg=NONE")
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	callback = adjust_colors,
})

vim.keymap.set("n", "<leader>=", function()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
	vim.cmd.colorscheme("vscode")
end)

vim.o.background = "light"
vim.cmd.colorscheme("vscode")
