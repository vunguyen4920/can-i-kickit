-- This file  needs to have same structure as nvconfig.lua
---@type ChadrcConfig
local M = {}

M.base46 = {
  ---@diagnostic disable-next-line: assign-type-mismatch
  theme = 'saigondark',

  integrations = {
    'blink',
    'dap',
    'devicons',
    'diffview',
    'flash',
    'git',
    'git-conflict',
    'grug_far',
    'lsp',
    'neogit',
    'nvshades',
    'rainbowdelimiters',
    'semantic_tokens',
    'syntax',
    'tbline',
    'telescope',
    'tiny-inline-diagnostic',
    'todo',
    'treesitter',
    'trouble',
    'vim-illuminate',
  },
}

M.ui = {
  cmp = {
    icons_left = true, -- only for non-atom styles!
    style = 'flat_dark', -- default/flat_light/flat_dark/atom/atom_colored
    -- for tailwind, css lsp etc
    format_colors = { lsp = true, icon = '󱓻' },
  },

  statusline = {
    theme = 'minimal',
    separator_style = 'round',
    order = { 'mode', 'file', 'git', '%=', 'lsp_msg', '%=', 'diagnostics', 'lsp', 'harpoon_marks', 'cwd', 'cursor' },
    modules = {
      harpoon_marks = function()
        local harpoon = require 'harpoon'
        if not harpoon or not harpoon.list or not harpoon:list().items then
          return ''
        end

        local marks = harpoon:list().items
        local stbuf = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
        local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(stbuf), ':.')
        local icon = '󰛢'

        if #marks == 0 then
          return ''
        end

        local label = ''

        for id, item in ipairs(marks) do
          if item.value == path then
            label = label .. '%#St_harpoon_active# ' .. id .. ' %*'
          else
            label = label .. '%#St_harpoon_inactive# ' .. id .. ' %*'
          end
        end

        local sep_l = ''
        local sep_r = '%#St_sep_r#' .. '' .. ' %#ST_EmptySpace#'
        return '%#St_harpoon_sep#' .. sep_l .. '%#St_harpoon_icon#' .. icon .. ' ' .. label .. sep_r
      end,
    },
  },

  telescope = {
    style = 'bordered',
  },

  tabufline = {
    show_numbers = true,
    lazyload = true,
  },
}

M.lsp = {
  signature = true,
}

return M
