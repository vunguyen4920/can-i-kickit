return {
  {
    'b0o/incline.nvim',
    opts = function()
      local devicons = require 'nvim-web-devicons'

      return {
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')

          local filetype = vim.api.nvim_get_option_value('filetype', { buf = props.buf })
          if filename == '' then
            if filetype then
              filename = filetype
            else
              filename = '[No Name]'
            end
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

          return {
            { get_git_diff() },
            { (ft_icon or '') .. ' ', guifg = ft_color, guibg = 'none' },
            { filename .. ' ', gui = vim.bo[props.buf].modified and 'bold,italic' or 'bold' },
          }
        end,
        window = {
          margin = {
            vertical = { top = 0, bottom = 0 }, -- shift to overlap window borders
            horizontal = { left = 0, right = 2 },
          },
          zindex = 50,
        },
      }
    end,
    event = 'BufEnter',
  },
}
