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
      columns = {
        'icon',
        'permissions',
        'size',
        'mtime',
      },
      float = {
        max_width = 0.5,
        max_height = 0.5,
      },
    },
  },
}
