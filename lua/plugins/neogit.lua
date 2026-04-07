return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'esmuellert/codediff.nvim', -- optional - Diff integration
      'folke/snacks.nvim',
    },
    init = function()
      dofile(vim.g.base46_cache .. 'git')
      dofile(vim.g.base46_cache .. 'git-conflict')
      dofile(vim.g.base46_cache .. 'neogit')
    end,
    opts = {
      graph_style = 'kitty',
      integrations = {
        codediff = true,
        snacks = true,
      },
      kind = 'tab',
      floating = {
        relative = 'editor',
        width = 0.9,
        height = 0.9,
        style = 'minimal',
        border = 'rounded',
      },
      disable_line_numbers = false,
      disable_relative_line_numbers = false,
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
