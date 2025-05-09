-- This file  needs to have same structure as nvconfig.lua
---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = 'tokyodark',

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

  hl_override = {
    Comment = { italic = true },
    ['@comment'] = { italic = true },
    Cursor = { bg = '#38a89d' },
  },
}

M.ui = {
  cmp = {
    icons_left = false, -- only for non-atom styles!
    style = 'default', -- default/flat_light/flat_dark/atom/atom_colored
    abbr_maxwidth = 60,
    -- for tailwind, css lsp etc
    format_colors = { lsp = true, icon = '󱓻' },
  },

  statusline = {
    theme = 'minimal',
    separator_style = 'round',
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
