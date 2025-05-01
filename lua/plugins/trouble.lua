return {
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
      dofile(vim.g.base46_cache .. 'trouble')

      return {}
    end,
    keys = {
      {
        '<leader>td',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Trouble Diagnostics Open',
      },
      {
        '<leader>tbd',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Trouble Diagnostics Current Buf Open',
      },
    },
  },
}
