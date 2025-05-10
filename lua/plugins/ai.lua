-- TODO: mcp is not working as expected with vars & commands
local M = {
  processing = false,
  spinner_index = 1,
  namespace_id = nil,
  timer = nil,
  spinner_symbols = {
    '⠋',
    '⠙',
    '⠹',
    '⠸',
    '⠼',
    '⠴',
    '⠦',
    '⠧',
    '⠇',
    '⠏',
  },
  filetype = 'codecompanion',
}

function M:get_buf(filetype)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == filetype then
      return buf
    end
  end
  return nil
end

function M:update_spinner()
  if not self.processing then
    self:stop_spinner()
    return
  end

  self.spinner_index = (self.spinner_index % #self.spinner_symbols) + 1

  local buf = self:get_buf(self.filetype)
  if buf == nil then
    return
  end

  -- Clear previous virtual text
  vim.api.nvim_buf_clear_namespace(buf, self.namespace_id, 0, -1)

  local last_line = vim.api.nvim_buf_line_count(buf) - 1
  vim.api.nvim_buf_set_extmark(buf, self.namespace_id, last_line, 0, {
    virt_lines = { { { self.spinner_symbols[self.spinner_index] .. ' Processing...', 'Comment' } } },
    virt_lines_above = true,
  })
end

function M:start_spinner()
  self.processing = true
  self.spinner_index = 0

  if self.timer then
    self.timer:stop()
    self.timer:close()
    self.timer = nil
  end

  self.timer = vim.loop.new_timer()
  self.timer:start(
    0,
    100,
    vim.schedule_wrap(function()
      self:update_spinner()
    end)
  )
end

function M:stop_spinner()
  self.processing = false

  if self.timer then
    self.timer:stop()
    self.timer:close()
    self.timer = nil
  end

  local buf = self:get_buf(self.filetype)
  if buf == nil then
    return
  end

  vim.api.nvim_buf_clear_namespace(buf, self.namespace_id, 0, -1)
end

function M:init()
  self.namespace_id = vim.api.nvim_create_namespace 'CodeCompanionSpinner'

  vim.api.nvim_create_augroup('CodeCompanionHooks', { clear = true })
  local group = vim.api.nvim_create_augroup('CodeCompanionHooks', {})

  vim.api.nvim_create_autocmd({ 'User' }, {
    pattern = 'CodeCompanionRequest*',
    group = group,
    callback = function(request)
      if request.match == 'CodeCompanionRequestStarted' then
        self:start_spinner()
      elseif request.match == 'CodeCompanionRequestFinished' then
        self:stop_spinner()
      end
    end,
  })
end

M:init()

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
        adapters = {
          openrouter = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              env = {
                url = 'https://openrouter.ai/api',
                api_key = 'OPENROUTER_API_KEY',
                chat_url = '/v1/chat/completions',
              },
              schema = {
                model = {
                  default = 'google/gemini-2.0-flash-001',
                },
              },
            })
          end,
        },
        display = {
          chat = {
            auto_scroll = false,
          },
        },
        strategies = {
          inline = {
            adapter = 'openrouter', --'copilot',
          },
          chat = {
            adapter = 'openrouter', --'copilot',
            send = {
              callback = function(chat)
                vim.cmd 'stopinsert'
                chat:add_buf_message { role = 'llm', content = '' }
                chat:submit()
              end,
              index = 1,
              description = 'Send',
            },
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
