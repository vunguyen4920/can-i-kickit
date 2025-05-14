return {
  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = '1.*',
    build = 'cargo +nightly build --release',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = { history = true, updateevents = 'TextChanged,TextChangedI' },
        config = function()
          -- vscode format
          require('luasnip.loaders.from_vscode').lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
          require('luasnip.loaders.from_vscode').lazy_load { paths = vim.g.vscode_snippets_path or '' }

          -- snipmate format
          require('luasnip.loaders.from_snipmate').load()
          require('luasnip.loaders.from_snipmate').lazy_load { paths = vim.g.snipmate_snippets_path or '' }

          -- lua format
          require('luasnip.loaders.from_lua').load()
          require('luasnip.loaders.from_lua').lazy_load { paths = vim.g.lua_snippets_path or '' }

          vim.api.nvim_create_autocmd('InsertLeave', {
            callback = function()
              if require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()] and not require('luasnip').session.jump_active then
                require('luasnip').unlink_current()
              end
            end,
          })
        end,
      },
      'folke/lazydev.nvim',
      {
        'saghen/blink.compat',
        version = '*',
        opts = {},
      },
    },
    init = function()
      dofile(vim.g.base46_cache .. 'blink')
    end,
    --- @module 'blink.cmp'
    --- @type function|blink.cmp.Config
    opts = function()
      local source_priority = {
        snippets = 4,
        lsp = 2,
        path = 3,
        buffer = 1,
      }

      return {
        keymap = {
          -- See :h blink-cmp-config-keymap for defining your own keymap
          preset = 'default',
        },
        appearance = {
          nerd_font_variant = 'mono',
        },
        completion = {
          documentation = { auto_show = false, auto_show_delay_ms = 500 },
        },
        sources = {
          per_filetype = {
            codecompanion = { 'codecompanion' },
          },
          default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
          providers = {
            lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
          },
        },
        snippets = { preset = 'luasnip' },
        cmdline = {
          enabled = false,
        },

        -- See :h blink-cmp-config-fuzzy for more information
        fuzzy = {
          implementation = 'lua',
          sorts = {
            function(a, b)
              local a_priority = source_priority[a.source_id]
              local b_priority = source_priority[b.source_id]
              if a_priority ~= b_priority then
                return a_priority > b_priority
              end
            end,
            -- 'exact',
            -- defaults
            'score',
            'sort_text',
          },
        },

        -- Shows a signature help window while you type arguments for a function
        signature = { enabled = true },
      }
    end,
  },
}
