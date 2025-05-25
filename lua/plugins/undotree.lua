return {
  'mbbill/undotree',
  init = function()
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_TreeReturnShape = '╲'
    vim.g.undotree_TreeVertShape = '│'
    vim.g.undotree_TreeSplitShape = '╱'
  end,
  keys = {
    {
      '<leader>u',
      vim.cmd.UndotreeToggle,
      desc = '[U]ndo Tree',
    },
  },
}
