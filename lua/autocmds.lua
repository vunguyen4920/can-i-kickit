-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Toggle cursorline on InsertLeave and WinEnter
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  group = vim.api.nvim_create_augroup('cursorline_toggle', { clear = true }),
  callback = function()
    vim.opt.cursorline = true
  end,
})

-- Disable cursorline on InsertEnter and WinLeave
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  group = 'cursorline_toggle',
  callback = function()
    vim.opt.cursorline = false
  end,
})
