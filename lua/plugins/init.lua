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
}
