return {
  {
    'OXY2DEV/markview.nvim',
    ft = { 'markdown', 'Avante', 'mcphub' },
    branch = 'main',
    opts = {
      preview = {
        filetypes = { 'markdown', 'Avante', 'mcphub' },
        ignore_buftypes = {},
      },
      max_length = 1000,
    },
    dependencies = {
      'saghen/blink.cmp',
    },
  },
}
