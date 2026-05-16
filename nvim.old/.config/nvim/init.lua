vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 8
vim.opt.updatetime = 100
vim.opt.numberwidth = 4

vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

vim.opt.number = true
vim.opt.relativenumber = true

local map = vim.keymap.set
local function ensure_commentstring()
  if vim.bo.commentstring ~= nil and vim.bo.commentstring ~= "" then
    return
  end
  local ft = vim.bo.filetype
  local fallback = {
    lua = "-- %s",
    vim = "\" %s",
    sh = "# %s",
    bash = "# %s",
    zsh = "# %s",
    python = "# %s",
    javascript = "// %s",
    typescript = "// %s",
    java = "// %s",
    c = "// %s",
    cpp = "// %s",
    rust = "// %s",
    go = "// %s",
  }
  vim.bo.commentstring = fallback[ft] or "# %s"
end
local function parse_commentstring()
  ensure_commentstring()
  local cs = vim.bo.commentstring
  local left, right = cs:match("^(.*)%%s(.*)$")
  if not left then
    left, right = cs, ""
  end
  return vim.trim(left), vim.trim(right or "")
end
local function toggle_comments(start_line, end_line)
  local left, right = parse_commentstring()
  if left == "" and right == "" then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local prefix_pat = vim.pesc(left)
  local suffix_pat = right ~= "" and vim.pesc(right) or nil

  local all_commented = true
  for _, line in ipairs(lines) do
    if line:match("%S") then
      if not line:match("^%s*" .. prefix_pat) then
        all_commented = false
        break
      end
      if suffix_pat and not line:match(suffix_pat .. "%s*$") then
        all_commented = false
        break
      end
    end
  end

  local updated = {}
  for i, line in ipairs(lines) do
    if not line:match("%S") then
      updated[i] = line
    elseif all_commented then
      local uncommented = line:gsub("^(%s*)" .. prefix_pat .. "%s?", "%1", 1)
      if suffix_pat then
        uncommented = uncommented:gsub("%s*" .. suffix_pat .. "%s*$", "", 1)
      end
      updated[i] = uncommented
    else
      local indent, body = line:match("^(%s*)(.*)$")
      if right ~= "" then
        updated[i] = indent .. left .. " " .. body .. " " .. right
      else
        updated[i] = indent .. left .. " " .. body
      end
    end
  end

  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, updated)
end

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- File explorer
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "File Explorer" })

-- Buffer navigation
map("n", "<S-l>", "<cmd>bnext<cr>")
map("n", "<S-h>", "<cmd>bprev<cr>")
map("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Close Buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprev<cr>", { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close buffer" })
map("n", "<leader>bl", function() require("telescope.builtin").buffers() end, { desc = "List all buffers" })
map("n", "<leader>bo", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end, { desc = "Close other buffers" })
map("n", "<leader>bb", "<C-^>", { desc = "Alternate buffer" })

-- Save / Quit
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<C-s>", function()
    vim.lsp.buf.format({ async = false }) -- sync = safer
    vim.cmd("w")
end, { desc = "Save + Format" })
-- map("n", "<C-s>", "<cmd>w<cr> function() vim.lsp.buf.format({ async = true }) end", { desc = "Save" })
-- map("i", "<C-s>", "<cmd>w<cr><Esc>", { desc = "Save and go to normal" })
map("i", "<C-s>", function()
    vim.cmd("stopinsert")
    vim.lsp.buf.format({ async = false })
    vim.cmd("w")
end, { desc = "Save + Format + Normal" })


-- Misc
map("n", "<Esc>", "<cmd>nohlsearch<cr>")
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("i", "<C-a>", "<Esc>ggVG", { desc = "Select all" })

-- Home / End fix
map("i", "<Find>", "<C-o>^", { desc = "Start of line" })
map("n", "<Find>", "^", { desc = "Start of line" })
map("i", "<Select>", "<C-o>$", { desc = "End of line" })
map("n", "<Select>", "$", { desc = "End of line" })

-- Diagnostics
map("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end)
map("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end)

-- LazyGit
map("n", "<leader>g", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })

-- VSCode-like indent/dedent
map("v", "<Tab>", ">gv", { desc = "Indent selection" })
map("v", "<S-Tab>", "<gv", { desc = "Dedent selection" })
map("n", "<Tab>", ">>", { desc = "Indent line" })
map("n", "<S-Tab>", "<<", { desc = "Dedent line" })
map("n", "<leader>/", function()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  toggle_comments(line, line)
end, { desc = "Toggle line comment" })
map("v", "<leader>/", function()
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  toggle_comments(start_line, end_line)
end, { desc = "Toggle selection comment" })

-- Insert mode: Copilot first, else indent
map("i", "<Tab>", function()
  local ok, copilot = pcall(require, "copilot.suggestion")
  if ok and copilot.is_visible() then
    copilot.accept()
  else
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<C-t>", true, false, true), "n", false
    )
  end
end, { desc = "Copilot accept or indent" })

map("i", "<S-Tab>", function()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<C-d>", true, false, true), "n", false
  )
end, { desc = "Dedent in insert" })

-- Copilot controls
map("n", "<leader>at", function()
  local clients = vim.lsp.get_clients({ name = "copilot" })
  if #clients > 0 then
    vim.cmd("Copilot disable")
    vim.notify("Copilot disabled", vim.log.levels.INFO)
  else
    vim.cmd("Copilot enable")
    vim.notify("Copilot enabled", vim.log.levels.INFO)
  end
end, { desc = "Toggle Copilot" })

map("n", "<leader>as", function()
  require("copilot.suggestion").toggle_auto_trigger()
  vim.notify("Auto-trigger toggled", vim.log.levels.INFO)
end, { desc = "Toggle auto suggestion" })

-- Code actions under <leader>c
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format file" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>ci", vim.lsp.buf.hover, { desc = "Hover info" })
map("n", "<leader>cR", vim.lsp.buf.references, { desc = "References" })
map("n", "<leader>cD", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<leader>ct", vim.lsp.buf.type_definition, { desc = "Type definition" })
map("n", "<leader>cs", vim.lsp.buf.signature_help, { desc = "Signature help" })
map("n", "<leader>cI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "<leader>cl", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
map("n", "<leader>cq", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })
