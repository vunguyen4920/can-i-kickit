-- TODO: Learn DAP
return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'mason-org/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'leoluz/nvim-dap-go',
    },
    keys = {
      {
        '<F5>',
        function()
          require('dap').continue()
        end,
        desc = 'Debug: Start/Continue',
      },
      {
        '<F1>',
        function()
          require('dap').step_into()
        end,
        desc = 'Debug: Step Into',
      },
      {
        '<F2>',
        function()
          require('dap').step_over()
        end,
        desc = 'Debug: Step Over',
      },
      {
        '<F3>',
        function()
          require('dap').step_out()
        end,
        desc = 'Debug: Step Out',
      },
      {
        '<leader>b',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Debug: Toggle Breakpoint',
      },
      {
        '<leader>B',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      {
        '<F7>',
        function()
          require('dapui').toggle()
        end,
        desc = 'Debug: See last session result.',
      },
    },
    init = function()
      dofile(vim.g.base46_cache .. 'dap')
    end,
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'delve',
        },
      }

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }

      -- Change breakpoint icons
      vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
      vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
      local breakpoint_icons = vim.g.have_nerd_font
          and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
        or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
      for type, icon in pairs(breakpoint_icons) do
        local tp = 'Dap' .. type
        local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
        vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
      end

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Install golang specific config
      require('dap-go').setup {
        delve = {
          -- On Windows delve must be run attached or it crashes.
          -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
          detached = vim.fn.has 'win32' == 0,
        },
      }
    end,
  },
  {
    'chrisgrieser/nvim-chainsaw',
    opts = {
      marker = '🚀',
    },
    config = function(_, opts)
      require('chainsaw').setup(opts)
    end,
    keys = function()
      local chainsaw = require 'chainsaw'
      return {
        {
          '<leader>cv',
          function()
            chainsaw.variableLog()
          end,
          desc = 'Chainsaw Variable Log',
        },
        {
          '<leader>co',
          function()
            chainsaw.objectLog()
          end,
          desc = 'Chainsaw Object Log',
        },
        {
          '<leader>cs',
          function()
            chainsaw.stacktraceLog()
          end,
          desc = 'Chainsaw Stacktrace Log',
        },
        {
          '<leader>cas',
          function()
            chainsaw.assertLog()
          end,
          desc = 'Chainsaw Assert Log',
        },
        {
          '<leader>cm',
          function()
            chainsaw.messageLog()
          end,
          desc = 'Chainsaw Message Log',
        },
        {
          '<leader>cb',
          function()
            chainsaw.beepLog()
          end,
          desc = 'Chainsaw Beep Log',
        },
        {
          '<leader>ct',
          function()
            chainsaw.timeLog()
          end,
          desc = 'Chainsaw Time Log',
        },
        {
          '<leader>cd',
          function()
            chainsaw.debugLog()
          end,
          desc = 'Chainsaw Debug Log',
        },
        {
          '<leader>cr',
          function()
            chainsaw.removeLogs()
          end,
          desc = 'Chainsaw Remove Logs',
        },
      }
    end,
  },
}
