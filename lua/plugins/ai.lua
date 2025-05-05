-- TODO: mcp is not working as expected
return {
  {
    'zbirenbaum/copilot.lua',
    enabled = true,
    cmd = { 'Copilot' },
    build = ':Copilot auth',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'olimorris/codecompanion.nvim',
    cmd = { 'CodeCompanionChat', 'CodeCompanion', 'CodeCompanionActions' },
    opts = function()
      --[[ openrouter = {
            __inherited_from = 'openai',
            endpoint = 'https://openrouter.ai/api/v1',
            api_key_name = 'OPENROUTER_API_KEY',
            model = 'openai/gpt-4o-mini',
      } ]]

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd [[cab cc CodeCompanion]]

      return {
        extensions = {
          mcphub = {
            callback = 'mcphub.extensions.codecompanion',
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true,
            },
          },
        },
        strategies = {
          chat = {
            keymaps = {
              close = {
                modes = { n = 'q', i = '<C-c>' },
              },
              stop = {
                modes = { n = 's' },
              },
            },
          },
        },
      }
    end,
    keys = {
      { '<leader>ac', '<cmd>CodeCompanionActions<cr>', desc = 'AI [C]ode Actions', mode = { 'n', 'v' } },
      { '<leader>at', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'AI [T]oggle', mode = { 'n', 'v' } },
      { '<leader>aa', '<cmd>CodeCompanionChat Add<cr>', desc = 'AI [A]dd to Chat', mode = { 'v' } },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'ravitemer/mcphub.nvim',
        dependencies = {
          'nvim-lua/plenary.nvim', -- Required for Job and HTTP requests
        },
        event = 'VeryLazy',
        build = 'bundled_build.lua',
        opts = {
          use_bundled_binary = true, -- Use the bundled binary instead of the global one
        },
        keys = {
          { '<leader>mcp', '<cmd>MCPHub<cr>', desc = '[MCP]Hub' },
        },
      },
    },
  },
  {
    'milanglacier/minuet-ai.nvim',
    enabled = true,
    event = 'BufReadPre',
    opts = {
      provider = 'codestral',
      notify = 'debug',
      n_completions = 1,
      add_single_line_entry = false,
      virtualtext = {
        auto_trigger_ft = {
          'lua',
          'javascript',
          'typescript',
          'javascriptreact',
          'typescriptreact',
          'vue',
          'svelte',
        },
        auto_trigger_ignore_ft = { 'oil', 'codecompanion' },
        keymap = {
          accept = '<Tab>', -- Accept whole completion
          accept_line = '<A-a>', -- Accept one line
          accept_n_lines = '<A-z>', -- Accept n lines (prompts for number)
          prev = '<A-[>', -- Cycle to previous completion item
          next = '<A-]>', -- Cycle to next completion item
          dismiss = '<A-e>', -- Dismiss virtual text
        },
      },
      provider_options = {
        codestral = {
          optional = {
            max_tokens = 256,
            stop = { '\n\n' },
          },
        },
      },
    },
  },
}
