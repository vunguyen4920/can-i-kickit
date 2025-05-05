return {
  {
    'OXY2DEV/markview.nvim',
    ft = { 'markdown', 'codecompanion', 'mcphub' },
    branch = 'main',
    opts = {
      preview = {
        filetypes = { 'markdown', 'codecompanion', 'mcphub' },
        ignore_buftypes = {},
      },
      max_length = 1000,
    },
    dependencies = {
      'saghen/blink.cmp',
    },
  },
}
