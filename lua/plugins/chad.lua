return {
  {
    'nvchad/ui',
    lazy = false,
    version = nil,
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-tree/nvim-web-devicons', lazy = true },
      'nvchad/volt',
    },
    init = function()
      dofile(vim.g.base46_cache .. 'defaults')
      dofile(vim.g.base46_cache .. 'statusline')
      dofile(vim.g.base46_cache .. 'tbline')
      dofile(vim.g.base46_cache .. 'devicons')
      dofile(vim.g.base46_cache .. 'nvshades')
    end,
    config = function()
      require 'nvchad'

      local map = vim.keymap.set

      map('n', '<C-n>', function() require('nvchad.tabufline').next() end, { desc = 'buffer goto next' })

      map('n', '<C-p>', function() require('nvchad.tabufline').prev() end, { desc = 'buffer goto prev' })

      map('n', '<C-c>', function() require('nvchad.tabufline').close_buffer() end, { desc = 'buffer close' })

      map('n', '<leader>tp', function() require('nvchad.themes').open() end, { desc = '[T]heme [P]ick' })
    end,
  },
  {
    'nvchad/base46',
    version = nil,
    build = function() require('base46').load_all_highlights() end,
  },
}
