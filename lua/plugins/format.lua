---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  local conform = require 'conform'
  for i = 1, select('#', ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        css = { 'prettierd', 'prettier', stop_after_first = true },
        scss = { 'prettierd', 'prettier', stop_after_first = true },
        sass = { 'prettierd', 'prettier', stop_after_first = true },
        graphql = function(bufnr)
          return { first(bufnr, 'prettierd', 'prettier'), 'eslint_d' }
        end,
        html = { 'prettierd', 'prettier', stop_after_first = true },
        javascript = function(bufnr)
          return { first(bufnr, 'prettierd', 'prettier'), 'eslint_d' }
        end,
        javascriptreact = function(bufnr)
          return { first(bufnr, 'prettierd', 'prettier'), 'eslint_d' }
        end,
        json = function(bufnr)
          return { first(bufnr, 'prettierd', 'prettier'), 'eslint_d' }
        end,
        jsonc = function(bufnr)
          return { first(bufnr, 'prettierd', 'prettier'), 'eslint_d' }
        end,
        markdown = function(bufnr)
          return { first(bufnr, 'prettierd', 'prettier'), 'markdownlint' }
        end,
        svelte = function(bufnr)
          return { first(bufnr, 'prettierd', 'prettier'), 'eslint_d' }
        end,
        typescript = function(bufnr)
          return { first(bufnr, 'prettierd', 'prettier'), 'eslint_d' }
        end,
        typescriptreact = function(bufnr)
          return { first(bufnr, 'prettierd', 'prettier'), 'eslint_d' }
        end,
        vue = function(bufnr)
          return { first(bufnr, 'prettierd', 'prettier'), 'eslint_d' }
        end,
        xml = { 'prettierd', 'prettier', stop_after_first = true },
        yaml = { 'prettierd', 'prettier', stop_after_first = true },
        lua = { 'stylua' },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
