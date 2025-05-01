return {
  {
    'echasnovski/mini.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('mini.move').setup()
      require('mini.splitjoin').setup()

      local gen_spec = require('mini.ai').gen_spec
      require('mini.ai').setup {
        n_lines = 500,
        custom_textobjects = {

          -- Function definition (needs treesitter queries with these captures)
          c = gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },
          F = gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },

          o = gen_spec.treesitter {
            a = { '@conditional.outer', '@loop.outer' },
            i = { '@conditional.inner', '@loop.inner' },
          },

          -- Whole buffer
          g = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line '$',
              col = math.max(vim.fn.getline('$'):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
      }

      -- Per buffer
      local spec_pair = require('mini.ai').gen_spec.pair
      vim.b.miniai_config = {
        custom_textobjects = {
          ['*'] = spec_pair('*', '*', { type = 'greedy' }),
          ['_'] = spec_pair('_', '_', { type = 'greedy' }),
        },
      }
    end,
  },
}
