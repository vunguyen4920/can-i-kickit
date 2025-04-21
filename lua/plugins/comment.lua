return {
  {
    'numToStr/Comment.nvim',
    event = 'BufReadPost',
    config = function()
      local prehook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      ---@diagnostic disable-next-line: missing-fields
      require('Comment').setup {
        padding = true,
        sticky = true,
        ignore = '^$',
        pre_hook = prehook,
      }
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        opts = {},
        config = function()
          vim.g.skip_ts_context_commentstring_module = true
        end,
        event = 'BufReadPost',
      },
    },
  },
}
