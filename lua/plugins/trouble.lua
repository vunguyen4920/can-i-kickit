return {
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function() dofile(vim.g.base46_cache .. 'trouble') end,
    opts = {},
    keys = {
      {
        '<M-t><M-t>',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = '[T]rouble Diagnostics Open',
      },
      {
        '<M-t><space>',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = '[T]rouble Diagnostics Current Buf Open',
      },
    },
  },
}
