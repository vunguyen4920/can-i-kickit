return {
  {
    'zbirenbaum/copilot.lua',
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
        auto_suggestions_provider = 'copilot',
        suggestion = {
          debounce = 800,
          throttle = 800,
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
}
