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
    opts = function()
      local conform = require 'conform'

      return {
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
        formatters = {
          prettier = { require_cwd = true },
          eslint_d = { require_cwd = true },
          biome = { require_cwd = true },
        },
        formatters_by_ft = {
          css = { 'prettier', stop_after_first = true },
          scss = { 'prettier', stop_after_first = true },
          sass = { 'prettier', stop_after_first = true },
          graphql = function(bufnr)
            if conform.get_formatter_info('biome', bufnr).available then
              return { 'biome' }
            end

            return { first(bufnr, 'prettier'), 'eslint_d' }
          end,
          html = { 'prettier', stop_after_first = true },
          javascript = function(bufnr)
            if conform.get_formatter_info('biome', bufnr).available then
              return { 'biome' }
            end
            return { first(bufnr, 'prettier'), 'eslint_d' }
          end,
          javascriptreact = function(bufnr)
            if conform.get_formatter_info('biome', bufnr).available then
              return { 'biome' }
            end
            return { first(bufnr, 'prettier'), 'eslint_d' }
          end,
          json = function(bufnr)
            if conform.get_formatter_info('biome', bufnr).available then
              return { 'biome' }
            end
            return { first(bufnr, 'prettier'), 'eslint_d' }
          end,
          jsonc = function(bufnr)
            if conform.get_formatter_info('biome', bufnr).available then
              return { 'biome' }
            end
            return { first(bufnr, 'prettier'), 'eslint_d' }
          end,
          markdown = function(bufnr)
            return { first(bufnr, 'prettier'), 'markdownlint' }
          end,
          svelte = function(bufnr)
            if conform.get_formatter_info('biome', bufnr).available then
              return { 'biome' }
            end
            return { first(bufnr, 'prettier'), 'eslint_d' }
          end,
          typescript = function(bufnr)
            if conform.get_formatter_info('biome', bufnr).available then
              return { 'biome' }
            end
            return { first(bufnr, 'prettier'), 'eslint_d' }
          end,
          typescriptreact = function(bufnr)
            if conform.get_formatter_info('biome', bufnr).available then
              return { 'biome' }
            end
            return { first(bufnr, 'prettier'), 'eslint_d' }
          end,
          vue = function(bufnr)
            if conform.get_formatter_info('biome', bufnr).available then
              return { 'biome' }
            end
            return { first(bufnr, 'prettier'), 'eslint_d' }
          end,
          xml = { 'prettier', stop_after_first = true },
          yaml = { 'prettier', stop_after_first = true },
          lua = { 'stylua' },
        },
      }
    end,
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

      vim.api.nvim_create_user_command('FormatDisable', function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = 'Disable autoformat-on-save',
        bang = true,
      })
      vim.api.nvim_create_user_command('FormatEnable', function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = 'Re-enable autoformat-on-save',
      })
    end,
  },
}
