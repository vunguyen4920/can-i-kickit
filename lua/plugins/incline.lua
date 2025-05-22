return {
  {
    'b0o/incline.nvim',
    opts = function()
      local devicons = require 'nvim-web-devicons'

      return {
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          if filename == '' then
            filename = '[No Name]'
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)

          local function get_git_diff()
            local icons = { removed = '', changed = '', added = '' }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. ' ' .. signs[name], group = 'Diff' .. name })
                table.insert(labels, { ' ' })
              end
            end
            if #labels > 0 then
              table.insert(labels, { '| ' })
            end
            return labels
          end

          local function get_harpoon_items()
            local harpoon = require 'harpoon'
            local marks = harpoon:list().items
            local current_file_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':.')
            local label = {}

            for id, item in ipairs(marks) do
              if item.value == current_file_path then
                table.insert(label, { id .. ' ', guifg = '#FFFFFF', gui = 'bold' })
              else
                table.insert(label, { id .. ' ', guifg = '#434852' })
              end
            end

            if #label > 0 then
              table.insert(label, 1, { '󰛢 ', guifg = '#61AfEf' })
              table.insert(label, { '| ' })
            end
            return label
          end

          return {
            { get_git_diff() },
            { get_harpoon_items() },
            { (ft_icon or '') .. ' ', guifg = ft_color, guibg = 'none' },
            { filename .. ' ', gui = vim.bo[props.buf].modified and 'bold,italic' or 'bold' },
            { '|  ' .. vim.api.nvim_win_get_number(props.win), group = 'DevIconWindows' },
          }
        end,
        hide = {
          cursorline = 'focused_win',
        },
      }
    end,
    event = 'BufEnter',
  },
}
