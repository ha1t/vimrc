-- my vimrc

vim.opt.termguicolors = true
vim.opt.winblend = 0 -- ウィンドウの不透明度
vim.opt.pumblend = 0 -- ポップアップメニューの不透明度

-- 背景を透過させる
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
]])

vim.keymap.set({'n', 'v', 's', 'o'}, ';', ':', { noremap = true })
vim.keymap.set({'n', 'v', 's', 'o'}, ':', ';', { noremap = true })

vim.api.nvim_create_user_command('EditVimrc', 'edit $MYVIMRC', {})
vim.api.nvim_create_user_command('ReloadVimrc', 'source $MYVIMRC', {})


