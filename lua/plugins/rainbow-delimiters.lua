return {
  {
    'hiphish/rainbow-delimiters.nvim',
    event = 'BufReadPost',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    init = function()
      dofile(vim.g.base46_cache .. 'rainbowdelimiters')
    end,
  },
}
