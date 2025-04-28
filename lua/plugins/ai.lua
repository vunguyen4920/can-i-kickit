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
    'yetone/avante.nvim',
    enabled = true,
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    opts = function()
      dofile(vim.g.base46_cache .. 'avante')

      return {
        provider = 'copilot',
        --[[ provider = 'openrouter',
        vendors = {
          openrouter = {
            __inherited_from = 'openai',
            endpoint = 'https://openrouter.ai/api/v1',
            api_key_name = 'OPENROUTER_API_KEY',
            model = 'openai/gpt-4o-mini',
          },
        }, ]]
        system_prompt = function()
          local hub = require('mcphub').get_hub_instance()

          return hub:get_active_servers_prompt()
        end,
        custom_tools = function()
          return {
            require('mcphub.extensions.avante').mcp_tool(),
          }
        end,
        disabled_tools = {
          'git_diff',
          'git_commit',
          'list_files',
          'search_files',
          'read_file',
          'create_file',
          'rename_file',
          'delete_file',
          'create_dir',
          'rename_dir',
          'delete_dir',
          'bash',
        },
      }
    end,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
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
        auto_trigger_ignore_ft = { 'oil', 'AvanteInput' },
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
  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', -- Required for Job and HTTP requests
    },
    event = 'VeryLazy',
    build = 'bundled_build.lua',
    opts = {
      use_bundled_binary = true, -- Use the bundled binary instead of the global one
      extensions = {
        avante = {
          make_slash_commands = true, -- make /slash commands from MCP server prompts
        },
      },
    },
    keys = {
      { '<leader>mcp', '<cmd>MCPHub<cr>', desc = 'MCPHub' },
    },
  },
}
