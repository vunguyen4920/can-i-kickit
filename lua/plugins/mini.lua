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

      local map_combo = require('mini.keymap').map_combo
      local mode = { 'i', 'c', 'x', 's' }
      map_combo('i', 'kk', '<BS><BS><Esc>[s1z=gi<Right>') -- fix spelling

      local map_multistep = require('mini.keymap').map_multistep

      local tab_steps = {
        'jump_after_tsnode', -- Jump after current node end
        'jump_after_close', -- Jump after closing chars like )]}"'`
      }
      map_multistep('i', '<C-l>', tab_steps)

      local shifttab_steps = {
        'jump_before_tsnode', -- Jump before current node start
        'jump_before_open', -- Jump before opening chars like ([{"'`
      }
      map_multistep('i', '<C-h>', shifttab_steps)
    end,
  },
}
