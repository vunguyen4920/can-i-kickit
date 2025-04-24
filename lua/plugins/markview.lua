return {
  {
    'OXY2DEV/markview.nvim',
    ft = { 'markdown', 'Avante' },
    branch = 'main',
    opts = {
      preview = {
        filetypes = { 'markdown', 'Avante' },
        ignore_buftypes = {},
      },
      max_length = 1000,
    },
    dependencies = {
      'saghen/blink.cmp',
    },
  },
}
