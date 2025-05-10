return {
  {
    'RRethy/vim-illuminate',
    event = 'BufReadPost',
    init = function()
      dofile(vim.g.base46_cache .. 'vim-illuminate')
    end,
  },
}
