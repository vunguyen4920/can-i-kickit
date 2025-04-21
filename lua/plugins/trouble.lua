return {
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    keys = {
      {
        '<leader>td',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Trouble Diagnostics Open',
      },
      {
        '<leader>tD',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Trouble Diagnostics Current Buf Open',
      },
    },
  },
}
