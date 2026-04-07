return {
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    init = function() vim.opt.sessionoptions:remove { 'blank' } end,
    opts = {},
  },
}
