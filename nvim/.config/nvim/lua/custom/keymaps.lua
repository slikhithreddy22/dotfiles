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

vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', {
  desc = 'Quit window',
})
