vim.keymap.set('n', '<leader>R', '<cmd>source $MYVIMRC<CR>', {
  desc = 'Reload nvim config',
})

vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', {
  desc = 'Save file',
})

vim.keymap.set('i', '<C-s>', '<Esc><cmd>w<CR>', {
  desc = 'Save file',
})

vim.keymap.set('n', '<C-a>', 'ggVG', {
  desc = 'Select all in file',
})

vim.keymap.set('n', '<leader>qq', '<cmd>q<CR>', {
  desc = 'Quit window',
})

vim.keymap.set('n', '<leader>qa', '<cmd>qa<CR>', {
  desc = 'Quit all',
})

-- Buffer management
vim.keymap.set('n', '<leader>bb', '<C-^>', { desc = 'Alternate buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bl', '<cmd>Telescope buffers<CR>', { desc = 'List buffers' })
