return {
	-- Solarized Osaka theme
	-- {
	--   "craftzdog/solarized-osaka.nvim",
	--   lazy = false,
	--   priority = 1000, -- load before everything else
	--   config = function()
	--     require("solarized-osaka").setup({
	--       transparent = false,
	--       terminal_colors = true,
	--       styles = {
	--         comments = { italic = true },
	--         keywords = { italic = true },
	--         functions = {},
	--         variables = {},
	--       },
	--       sidebars = { "neo-tree", "telescope", "lazy", "mason" },
	--     })
	--     vim.cmd("colorscheme solarized-osaka")
	--   end,
	-- },
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local function copilot_status()
				local ok, clients = pcall(vim.lsp.get_clients, { name = "copilot" })
				if not ok or #clients == 0 then
					return "󰚩 off"
				end
				local buf_clients = vim.lsp.get_clients({ name = "copilot", bufnr = 0 })
				if #buf_clients == 0 then
					return "󰚩 off"
				end
				return "󰚩 on"
			end

			require("lualine").setup({
				-- options = { theme = "solarized-osaka" },
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { copilot_status, "encoding", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},

	-- Syntax highlighting
	--   {
	--     "nvim-treesitter/nvim-treesitter",
	--     build = ":TSUpdate",
	--     config = function()
	--       require("nvim-treesitter.configs").setup({
	--         ensure_installed = {
	--           "lua", "vim", "vimdoc",
	--           "go", "python", "javascript", "typescript",
	--           "c", "cpp", "rust", "java",
	--         },
	--         highlight = { enable = true },
	--         indent = { enable = true },
	--       })
	--     end,
	--     init = function()
	--       vim.opt.foldmethod = "expr"
	--       vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	--       vim.opt.foldenable = false
	--     end,
	--   },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup()
			vim.treesitter.language.register(
				"lua",
				"vim",
				"vimdoc",
				"go",
				"python",
				"javascript",
				"typescript",
				"c",
				"cpp",
				"rust",
				"java"
			)
		end,
		init = function()
			-- new API in treesitter v1+
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldenable = false
		end,
	},
}
