return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = function()
      local harpoon = require 'harpoon'

      -- 4keys/8marks or 5keys/10marks etc.
      local function harpoon_select_maps(keys)
        local result = {}
        for i = 1, #keys do
          local key = keys:sub(i, i)

          table.insert(result, {
            '<C-' .. key .. '>',
            function()
              harpoon:list():select(i)
            end,
            desc = 'Harpoon Select ' .. i,
          })

          -- Control + Shift + key
          table.insert(result, {
            '<C-S-' .. key .. '>',
            function()
              harpoon:list():select(i + #keys)
            end,
            desc = 'Harpoon Select ' .. (i + #keys),
          })
        end
        return result
      end

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
        unpack(harpoon_select_maps 'hjkl;'),
      }
    end,
    opts = {},
  },
}
