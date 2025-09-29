

vim.keymap.set({'n', 'v', 's', 'o'}, ';', ':', { noremap = true })
vim.keymap.set({'n', 'v', 's', 'o'}, ':', ';', { noremap = true })

vim.api.nvim_create_user_command('EditVimrc', 'edit $MYVIMRC', {})
vim.api.nvim_create_user_command('ReloadVimrc', 'source $MYVIMRC', {})

