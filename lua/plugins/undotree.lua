return {
  {
    'jiaoshijie/undotree',
    opts = {
      ignore_filetype = { 'oil' },
    },
    keys = { -- load the plugin only when using it's keybinding:
      { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
}
