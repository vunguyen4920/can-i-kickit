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
      graph_style = 'kitty',
      integrations = {
        diffview = true,
        telescope = true,
      },
      kind = 'floating',
      floating = {
        relative = 'editor',
        width = 0.9,
        height = 0.9,
        style = 'minimal',
        border = 'rounded',
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
      }
    end,
  },
}
