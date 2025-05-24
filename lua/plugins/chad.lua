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

      map('n', '<C-n>', function()
        require('nvchad.tabufline').next()
      end, { desc = 'buffer goto next' })

      map('n', '<C-p>', function()
        require('nvchad.tabufline').prev()
      end, { desc = 'buffer goto prev' })

      map('n', '<leader>bc', function()
        require('nvchad.tabufline').close_buffer()
      end, { desc = 'buffer close' })

      map('n', '<leader>tp', function()
        require('nvchad.themes').open()
      end, { desc = 'Telescope [T]heme [P]ick' })

      -- toggleable
      map({ 'n', 't' }, '<leader>tv', function()
        require('nvchad.term').toggle { pos = 'vsp', id = 'vtoggleTerm' }
      end, { desc = 'terminal toggleable vertical term' })

      map({ 'n', 't' }, '<leader>tt', function()
        require('nvchad.term').toggle { pos = 'sp', id = 'htoggleTerm' }
      end, { desc = 'terminal toggleable horizontal term' })

      map({ 'n', 't' }, '<leader>tf', function()
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
    version = nil,
    build = function()
      require('base46').load_all_highlights()
    end,
  },
}
