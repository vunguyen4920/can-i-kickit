return {
  {
    'codethread/qmk.nvim',
    ft = 'dts',
    ---@type qmk.UserConfig
    opts = {
      name = 'corneo',
      variant = 'zmk',
      auto_format_pattern = '*.keymap',
      layout = {
        'x x x x x x _ _ x x x x x x',
        'x x x x x x _ _ x x x x x x',
        'x x x x x x _ _ x x x x x x',
        '_ _ _ x x x _ _ x x x _ _ _',
      },
    },
  },
}
