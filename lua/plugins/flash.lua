return {
  {
    'folke/flash.nvim',
    event = 'BufEnter',
    init = function()
      dofile(vim.g.base46_cache .. 'flash')
    end,
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = true,
        },
        char = {
          jump_labels = true,
        },
      },
    },
    keys = function()
      local flash = require 'flash'

      return {
        {
          mode = { 'n', 'x', 'o' },
          's',
          function()
            flash.jump()
          end,
          desc = 'Flash Jump',
        },
        {
          mode = { 'n', 'x', 'o' },
          'Z',
          function()
            flash.jump {
              pattern = vim.fn.expand '<cword>',
            }
          end,
          desc = 'Flash Remote',
        },
      }
    end,
  },
}
