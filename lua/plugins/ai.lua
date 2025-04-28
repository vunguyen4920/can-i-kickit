return {
  {
    'yetone/avante.nvim',
    enabled = true,
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    opts = function()
      dofile(vim.g.base46_cache .. 'avante')

      return {
        provider = 'openrouter',
        vendors = {
          openrouter = {
            __inherited_from = 'openai',
            endpoint = 'https://openrouter.ai/api/v1',
            api_key_name = 'OPENROUTER_API_KEY',
            model = 'google/gemini-2.0-flash-exp:free',
          },
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
      lsp = {
        enabled_ft = { '*' },
      },
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
        keymap = {
          -- accept whole completion
          accept = '<Tab>',
          -- accept one line
          accept_line = '<A-a>',
          -- accept n lines (prompts for number)
          accept_n_lines = '<A-z>',
          -- Cycle to prev completion item, or manually invoke completion
          prev = '<A-[>',
          -- Cycle to next completion item, or manually invoke completion
          next = '<A-]>',
          dismiss = '<A-e>',
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
