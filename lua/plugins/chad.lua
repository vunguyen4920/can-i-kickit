return {
  {
    'nvchad/ui',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-tree/nvim-web-devicons', lazy = true },
      'nvchad/volt',
    },
    config = function()
      require 'nvchad'

      dofile(vim.g.base46_cache .. 'defaults')
      dofile(vim.g.base46_cache .. 'statusline')
      dofile(vim.g.base46_cache .. 'devicons')
      dofile(vim.g.base46_cache .. 'nvshades')

      local map = vim.keymap.set

      map('n', '<tab>', function()
        require('nvchad.tabufline').next()
      end, { desc = 'buffer goto next' })

      map('n', '<S-tab>', function()
        require('nvchad.tabufline').prev()
      end, { desc = 'buffer goto prev' })

      map('n', '<leader>x', function()
        require('nvchad.tabufline').close_buffer()
      end, { desc = 'buffer close' })

      map('n', '<leader>tp', function()
        require('nvchad.themes').open()
      end, { desc = 'Telescope [T]heme [P]ick' })

      -- toggleable
      map({ 'n', 't' }, '<A-v>', function()
        require('nvchad.term').toggle { pos = 'vsp', id = 'vtoggleTerm' }
      end, { desc = 'terminal toggleable vertical term' })

      map({ 'n', 't' }, '<A-S-H>', function()
        require('nvchad.term').toggle { pos = 'sp', id = 'htoggleTerm' }
      end, { desc = 'terminal toggleable horizontal term' })

      map({ 'n', 't' }, '<A-i>', function()
        require('nvchad.term').toggle { pos = 'float', id = 'floatTerm' }
      end, { desc = 'terminal toggle floating term' })

      local autocmd = vim.api.nvim_create_autocmd
      autocmd('BufReadPost', {
        pattern = '*',
        callback = function()
          local line = vim.fn.line '\'"'
          if line > 1 and line <= vim.fn.line '$' and vim.bo.filetype ~= 'commit' and vim.fn.index({ 'xxd', 'gitrebase' }, vim.bo.filetype) == -1 then
            vim.cmd 'normal! g`"'
          end
        end,
      })
    end,
  },
  {
    'nvchad/base46',
    build = function()
      require('base46').load_all_highlights()
    end,
  },
}
