local function find_nearest_node_modules_dir()
  local current_dir = vim.fn.expand '%:p:h'
  while current_dir ~= '/' do
    if vim.fn.isdirectory(current_dir .. '/node_modules') == 1 then
      return current_dir
    end
    current_dir = vim.fn.fnamemodify(current_dir, ':h')
  end

  return nil
end

local function find_project_root()
  local current_dir = vim.fn.expand '%:p:h'

  -- Files/directories that indicate project root
  local project_indicators = {
    'package.json',
    '.git',
    'biome.json',
    'biome.jsonc',
    'eslint.config.js',
    'eslint.config.mjs',
    'eslint.config.cjs',
    '.eslintrc.js',
    '.eslintrc.json',
    '.eslintrc.yml',
    '.eslintrc.yaml',
  }

  while current_dir ~= '/' do
    for _, indicator in ipairs(project_indicators) do
      local path = current_dir .. '/' .. indicator
      if vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1 then
        return current_dir
      end
    end
    current_dir = vim.fn.fnamemodify(current_dir, ':h')
  end

  return nil
end

local function file_exists_in_root(project_root, filename)
  return vim.fn.filereadable(project_root .. '/' .. filename) == 1
end

local function has_eslint_in_package_json(project_root)
  local package_json_path = project_root .. '/package.json'

  if not file_exists_in_root(project_root, 'package.json') then
    return false
  end

  local ok, package_data = pcall(vim.fn.json_decode, vim.fn.readfile(package_json_path))
  return ok and package_data and package_data.eslintConfig ~= nil
end

local function get_js_linter()
  local project_root = find_project_root()

  if not project_root then
    return nil
  end

  if file_exists_in_root(project_root, 'biome.json') or file_exists_in_root(project_root, 'biome.jsonc') then
    return 'biomejs'
  end

  local eslint_config_files = {
    'eslint.config.js',
    'eslint.config.mjs',
    'eslint.config.cjs',
    '.eslintrc.js',
    '.eslintrc.json',
    '.eslintrc.yml',
    '.eslintrc.yaml',
  }

  for _, config_file in ipairs(eslint_config_files) do
    if file_exists_in_root(project_root, config_file) then
      return 'eslint_d'
    end
  end

  if has_eslint_in_package_json(project_root) then
    return 'eslint_d'
  end

  return nil
end

return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        lua = { 'selene' },
        luau = { 'selene' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          local filetype = vim.bo.filetype
          local js_filetypes = {
            'javascript',
            'typescript',
            'javascriptreact',
            'typescriptreact',
            'svelte',
            'vue',
          }

          local json_filetypes = {
            'json',
            'jsonc',
          }

          if not vim.tbl_contains(js_filetypes, filetype) and not vim.tbl_contains(json_filetypes, filetype) then
            lint.try_lint()
            return
          end

          local linter = get_js_linter()

          if not linter then
            return
          end

          lint.linters_by_ft[filetype] = { linter }

          -- Change to project directory for linting
          local original_cwd = vim.fn.getcwd()
          local node_modules_dir = find_nearest_node_modules_dir()

          if node_modules_dir then
            vim.cmd('silent! cd ' .. node_modules_dir)
          end

          -- Run the linter
          lint.try_lint()

          -- Restore original directory
          vim.cmd('silent! cd ' .. original_cwd)
        end,
      })
    end,
    init = function()
      -- Show linters for the current buffer's file type
      vim.api.nvim_create_user_command('LintInfo', function()
        local filetype = vim.bo.filetype
        local linters = require('lint').linters_by_ft[filetype]

        if linters then
          print('Linters for ' .. filetype .. ': ' .. table.concat(linters, ', '))
        else
          print('No linters configured for filetype: ' .. filetype)
        end
      end, {})
    end,
  },
}
