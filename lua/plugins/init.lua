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
    opts = { signs = false },
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
    opts = {},
  },
}
