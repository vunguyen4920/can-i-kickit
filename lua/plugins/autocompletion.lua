return {
  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    build = 'cargo +nightly build --release',
    dependencies = {
      { -- Snippet Engine
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
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
            end,
          },
        },
        opts = { history = true, updateevents = 'TextChanged,TextChangedI' },
        config = function()
          require('luasnip').filetype_extend('typescript', { 'tsdoc' })
          require('luasnip').filetype_extend('javascript', { 'jsdoc' })
          require('luasnip').filetype_extend('lua', { 'luadoc' })
          require('luasnip').filetype_extend('python', { 'pydoc' })
          require('luasnip').filetype_extend('rust', { 'rustdoc' })
          require('luasnip').filetype_extend('cs', { 'csharpdoc' })
          require('luasnip').filetype_extend('java', { 'javadoc' })
          require('luasnip').filetype_extend('c', { 'cdoc' })
          require('luasnip').filetype_extend('cpp', { 'cppdoc' })
          require('luasnip').filetype_extend('php', { 'phpdoc' })
          require('luasnip').filetype_extend('kotlin', { 'kdoc' })
          require('luasnip').filetype_extend('ruby', { 'rdoc' })
          require('luasnip').filetype_extend('sh', { 'shelldoc' })

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
    },
    init = function() dofile(vim.g.base46_cache .. 'blink') end,
    --- @module 'blink.cmp'
    --- @type function|blink.cmp.Config
    opts = function()
      return {
        keymap = { -- See :h blink-cmp-config-keymap for defining your own keymap
          preset = 'default',
        },
        appearance = { nerd_font_variant = 'mono' },
        completion = {
          menu = { border = 'single' },
          documentation = { auto_show = false, auto_show_delay_ms = 500, window = { border = 'single' } },
        },
        sources = {
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
          implementation = 'prefer_rust',
          sorts = {
            -- 'exact',
            -- defaults
            'score',
            'sort_text',
            'label',
          },
        },

        -- Shows a signature help window while you type arguments for a function
        signature = { enabled = true },
      }
    end,
  },
}
