return {
  {
    'kevinhwang91/nvim-ufo',
    event = 'BufReadPost',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    opts = {},
    config = function()
      require('ufo').setup {
        provider_selector = function()
          return { 'treesitter', 'indent' }
        end,
        close_fold_kinds_for_ft = {
          default = { 'imports', 'comment' },
        },
      }

      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 999 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 999
      vim.o.foldenable = true
    end,
  },
  {
    'chrisgrieser/nvim-origami',
    event = 'VeryLazy',
    opts = {}, -- needed even when using default config
  },
}
