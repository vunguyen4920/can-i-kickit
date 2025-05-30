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
    cmd = { 'Oil' },
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
    init = function()
      -- Close the window when oil is closed
      -- Also has the effect of quitting vim when the Oil buffer is the last one
      vim.api.nvim_create_autocmd('BufUnload', {
        pattern = 'oil://*',
        callback = function()
          if vim.api.nvim_buf_get_name(0) == '' then
            vim.cmd 'confirm q'
          end
        end,
      })

      -- If nvim is started with a directory argument, load oil immediately
      -- via https://github.com/folke/lazy.nvim/issues/533
      if vim.fn.argc() == 1 then
        local argv0 = vim.fn.argv(0)
        ---@cast argv0 string
        local stat = vim.uv.fs_stat(argv0)
        if stat and stat.type == 'directory' then
          require('lazy').load { plugins = { 'oil.nvim' } }
        end
      end
      if not require('lazy.core.config').plugins['oil.nvim']._.loaded then
        vim.api.nvim_create_autocmd('BufNew', {
          callback = function()
            if vim.fn.isdirectory(vim.fn.expand '<afile>') == 1 then
              require('lazy').load { plugins = { 'oil.nvim' } }
              -- Once oil is loaded, we can delete this autocmd
              return true
            end
          end,
        })
      end
    end,
    ---@module 'oil'
    ---@type oil.SetupOpts
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
          callback = function()
            local oil = require 'oil'
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()
            if not entry or not dir then
              return
            end

            local abs_path = dir .. entry.name
            vim.fn.setreg(vim.v.register, abs_path)
            vim.notify('Copied absolute path: ' .. abs_path, vim.log.levels.INFO)
          end,
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
