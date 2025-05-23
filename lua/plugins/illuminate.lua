return {
  {
    'RRethy/vim-illuminate',
    version = nil,
    event = 'BufReadPost',
    init = function()
      dofile(vim.g.base46_cache .. 'vim-illuminate')
    end,
  },
}
