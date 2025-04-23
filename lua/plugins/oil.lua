-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require('oil').get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ':~')
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

local detail = false

return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    cmd = { 'Oil' },
    priority = 1000,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {
        '-',
        '<cmd>Oil<CR>',
        mode = '',
        desc = '[EX]plorer',
      },
      {
        '_',
        '<cmd>Oil --float<CR>',
        mode = '',
        desc = '[E]xplorer [F]loat',
      },
    },
    opts = {
      view_options = {
        show_hidden = true,
      },
      columns = { 'icon' },
      float = {
        max_width = 0.5,
        max_height = 0.5,
      },
      win_options = {
        winbar = '%!v:lua.get_oil_winbar()',
      },
      keymaps = {
        ['q'] = {
          desc = 'Close oil and restore original buffer',
          callback = 'actions.close',
        },
        ['gY'] = {
          desc = 'Yank absolute path to clipboard',
          callback = 'actions.copy_entry_path',
        },
        ['gy'] = {
          desc = 'Yank relative path to clipboard',
          callback = function()
            local oil = require 'oil'
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()

            if not entry or not dir then
              return
            end

            local abs_path = dir .. entry.name
            local rel_path = vim.fn.fnamemodify(abs_path, ':.')

            vim.fn.setreg('+', rel_path)
            vim.notify('Copied relative path: ' .. rel_path, vim.log.levels.INFO)
          end,
        },
        ['gd'] = {
          desc = 'Toggle file detail view',
          callback = function()
            detail = not detail
            if detail then
              require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
            else
              require('oil').set_columns { 'icon' }
            end
          end,
        },
      },
    },
  },
}
