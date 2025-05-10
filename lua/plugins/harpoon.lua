return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = function()
      local harpoon = require 'harpoon'
      return {
        {
          '<leader>hm',
          function()
            harpoon:list():add()
          end,
          desc = 'Harpoon [M]ark',
        },
        {
          '<leader>hq',
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = 'Harpoon [Q]uick Menu',
        },
        {
          '<C-h>',
          function()
            harpoon:list():select(1)
          end,
          desc = 'Harpoon Select 1',
        },
        {
          '<C-j>',
          function()
            harpoon:list():select(2)
          end,
          desc = 'Harpoon Select 2',
        },
        {
          '<C-k>',
          function()
            harpoon:list():select(3)
          end,
          desc = 'Harpoon Select 3',
        },
        {
          '<C-l>',
          function()
            harpoon:list():select(4)
          end,
          desc = 'Harpoon Select 4',
        },
        {
          '<C-S-h>',
          function()
            harpoon:list():select(5)
          end,
          desc = 'Harpoon Select 5',
        },
        {
          '<C-S-j>',
          function()
            harpoon:list():select(6)
          end,
          desc = 'Harpoon Select 6',
        },
        {
          '<C-S-k>',
          function()
            harpoon:list():select(7)
          end,
          desc = 'Harpoon Select 7',
        },
        {
          '<C-S-l>',
          function()
            harpoon:list():select(8)
          end,
          desc = 'Harpoon Select 8',
        },
      }
    end,
    opts = {},
  },
}
