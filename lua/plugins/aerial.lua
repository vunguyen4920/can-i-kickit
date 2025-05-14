return {
  {
    'stevearc/aerial.nvim',
    cmd = { 'AerialToggle', 'AerialNext', 'AerialPrev' },
    keys = {
      { '<leader>ae', '<cmd>AerialToggle<cr>', desc = 'Toggle Aerial' },
    },
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
}
