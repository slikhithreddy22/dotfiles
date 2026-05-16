return {
  -- LSP + Mason
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        -- auto-install these when missing
        ensure_installed = {
          "gopls",        -- Go
          "clangd",       -- C / C++
          "pyright",      -- Python
          "ts_ls",        -- JS / TS
          -- rust_analyzer → handled by rustaceanvim (lang/rust.lua)
          -- jdtls         → handled by nvim-jdtls    (lang/java.lua)
        },
        automatic_installation = false,
      })

      -- auto-enable everything installed via Mason
      -- skip rust_analyzer and jdtls (their plugins handle setup)
      local skip = { rust_analyzer = true, jdtls = true }
      for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
        if not skip[server] then
          vim.lsp.config(server, {})
          vim.lsp.enable(server)
        end
      end
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}