-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'tpope/vim-sleuth', event = 'BufEnter' }, -- Detect tabstop and shiftwidth automatically
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      dofile(vim.g.base46_cache .. 'todo')
    end,
    opts = { signs = false },
  },
  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'iamyoki/buffer-reopen.nvim',
    event = 'BufEnter',
    opts = {},
  },
  {
    'lewis6991/spaceless.nvim',
    opts = {},
    event = 'BufReadPost',
  },
  {
    'sphamba/smear-cursor.nvim',
    event = 'BufEnter',
    opts = {},
  },
  {
    'mvllow/modes.nvim',
    tag = 'v0.2.1',
    event = 'BufEnter',
    opts = {
      colors = {
        copy = '#d7a65f',
        delete = '#c75c6a',
        insert = '#38a89d',
        visual = '#a485dd',
      },
    },
  },
}
