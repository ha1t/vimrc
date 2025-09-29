

vim.keymap.set({'n', 'v', 's', 'o'}, ';', ':', { noremap = true })
vim.keymap.set({'n', 'v', 's', 'o'}, ':', ';', { noremap = true })

vim.api.nvim_create_user_command('Restart', 'qa | nvim', {})

