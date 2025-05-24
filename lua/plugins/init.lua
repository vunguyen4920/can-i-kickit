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
    opts = {},
  },
}
