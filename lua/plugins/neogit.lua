return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
    },
    init = function()
      dofile(vim.g.base46_cache .. 'git')
      dofile(vim.g.base46_cache .. 'git-conflict')
      dofile(vim.g.base46_cache .. 'neogit')
    end,
    opts = {
      graph_style = 'unicode',
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
    keys = function()
      local neogit = require 'neogit'
      return {
        {
          '<leader>gg',
          neogit.open,
          desc = 'Git Neogit Open',
        },
        {
          '<leader>gs',
          function()
            neogit.open { kind = 'split' }
          end,
          desc = 'Git Neogit Open Split',
        },
      }
    end,
  },
}
