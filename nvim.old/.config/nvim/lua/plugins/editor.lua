return {
	-- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				window = { width = 30 },
				filesystem = {
					follow_current_file = { enabled = true },
					hijack_netrw_behavior = "open_current",
				},
			})
		end,
	},

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					previewer = true,
					preview = { treesitter = false },
				},
			})
		end,
		keys = {
			{ "<leader><leader>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>ff", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		},
	},

	-- Auto pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	-- Which-key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup()
			wk.add({
				{ "<leader>f", group = "Find" },
				{ "<leader>g", group = "Git" },
				{ "<leader>e", desc = "File Explorer" },
				{ "<leader>w", desc = "Save" },
				{ "<leader>q", desc = "Quit" },
				{ "<leader>x", desc = "Close Buffer" },

				-- Copilot group
				{ "<leader>a", group = "Copilot" },
				{ "<leader>at", desc = "Toggle Copilot" },
				{ "<leader>as", desc = "Toggle auto suggestion" },

				-- Code group
				{ "<leader>c", group = "Code" },
				{ "<leader>ca", desc = "Code action" },
				{ "<leader>cr", desc = "Rename symbol" },
				{ "<leader>cf", desc = "Format file" },
				{ "<leader>cd", desc = "Line diagnostics" },
				{ "<leader>ci", desc = "Hover info" },
				{ "<leader>cR", desc = "References" },
				{ "<leader>cD", desc = "Go to definition" },
				{ "<leader>ct", desc = "Type definition" },
				{ "<leader>cs", desc = "Signature help" },
				{ "<leader>cI", desc = "Go to implementation" },
				{ "<leader>cl", desc = "Diagnostics loclist" },
				{ "<leader>cq", desc = "Diagnostics quickfix" },

				-- Buffer group
				{ "<leader>b", group = "Buffers" },
				{ "<leader>bn", desc = "Next buffer" },
				{ "<leader>bp", desc = "Prev buffer" },
				{ "<leader>bd", desc = "Close buffer" },
				{ "<leader>bl", desc = "List all buffers" },
				{ "<leader>bo", desc = "Close other buffers" },
				{ "<leader>bb", desc = "Alternate buffer" },

				{ "]e", desc = "Next error" },
				{ "[e", desc = "Prev error" },
			})
		end,
	},
}
