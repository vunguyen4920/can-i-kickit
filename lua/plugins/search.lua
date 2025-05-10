return {
  {
    'MagicDuck/grug-far.nvim',
    cmd = { 'GrugFar', 'GrugBarWithin' },
    init = function()
      dofile(vim.g.base46_cache .. 'grug_far')
    end,
    opts = {
      keymaps = {
        close = { n = 'q' },
      },
    },
    keys = function()
      local grug = require 'grug-far'

      return {
        {
          '<leader>ff',
          function()
            grug.open { transient = true }
          end,
          mode = '',
          desc = 'Grug [F]ind',
        },
        {
          '<leader>fw',
          function()
            grug.open {
              { prefills = { search = vim.fn.expand '<cword>' }, transient = true },
            }
          end,
          mode = '',
          desc = 'Grug [F]ind a [W]ord',
        },
        {
          '<leader>fc',
          function()
            grug.open {
              { prefills = { paths = vim.fn.expand '%', transient = true } },
            }
          end,
          mode = '',
          desc = 'Grug [F]ind [C]urrent',
        },
        {
          '<leader>fi',
          function()
            grug.open {
              { visualSelectionUsage = 'operate-within-range', transient = true },
            }
          end,
          mode = '',
          desc = 'Grug [F]ind [C]urrent',
        },
      }
    end,
  },
}
