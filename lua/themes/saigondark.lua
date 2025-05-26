-- TODO: Need more improvements and fixes
--
-- Credits to original https://github.com/tiagovla/tokyodark.nvim
-- This is modified version of it

---@type Base46Table
---@diagnostic disable-next-line: missing-fields
local M = {}

M.base_30 = {
  white = '#a0a8cd',
  darker_black = '#0a060d',
  black = '#0c080f', --  nvim bg
  black2 = '#060408',
  one_bg = '#1d1e29',
  one_bg2 = '#252631',
  one_bg3 = '#252631',
  grey = '#4C4653',
  grey_fg = '#3A2F44',
  grey_fg2 = '#4e4f5a',
  light_grey = '#545560',
  red = '#ee6d85',
  baby_pink = '#fd7c94',
  pink = '#f3627a',
  line = '#152E2B',
  green = '#98c379',
  vibrant_green = '#95c561',
  nord_blue = '#648ce1',
  blue = '#7199ee',
  yellow = '#d7a65f',
  sun = '#dfae67',
  purple = '#c383cc',
  dark_purple = '#9071c9',
  teal = '#38a89d',
  orange = '#f6955b',
  cyan = '#6bd1c7',
  statusline_bg = '#161722',
  lightbg = '#2a2b36',
  pmenu_bg = '#ee6d85',
  folder_bg = '#7199ee',
}

M.base_16 = {
  base00 = '#10080f',
  base01 = '#1b1c27',
  base02 = '#21222d',
  base03 = '#211b24',
  base04 = '#30313c',
  base05 = '#ccbfef',
  base06 = '#b2b9c6',
  base07 = '#a0a8cd',
  base08 = '#ee6d85',
  base09 = '#648ce1',
  base0A = '#7199ee',
  base0B = '#dfae67',
  base0C = '#6bd1c7',
  base0D = '#38a89d',
  base0E = '#c383cc',
  base0F = '#f3627a',
}

M.polish_hl = {
  defaults = {
    Comment = { italic = true },
    St_harpoon_active = {
      fg = M.base_30.yellow,
      bg = M.base_30.one_bg3,
      bold = true,
    },
    St_harpoon_inactive = {
      fg = M.base_30.white,
      bg = M.base_30.one_bg,
    },
    St_harpoon_icon = {
      fg = M.base_30.black,
      bg = M.base_30.yellow,
      bold = true,
    },
    St_harpoon_sep = {
      fg = M.base_30.yellow,
      bg = M.base_30.black,
    },
    ModesCopy = {
      bg = M.base_30.sun,
    },
    ModesDelete = {
      bg = M.base_30.pink,
    },
    ModesInsert = {
      bg = M.base_30.cyan,
    },
    ModesVisual = {
      bg = M.base_30.purple,
    },
    DebugPrintLine = {
      bg = M.base_30.one_bg,
      italic = true,
      bold = true,
    },
  },
  treesitter = {
    ['@comment'] = { italic = true },
  },
}

M.type = 'dark'

M = require('base46').override_theme(M, 'saigondark')

return M
