vim.filetype.add {
  extension = {
    kbd = 'clojure',
  },
  filename = {
    ['.eslintrc.json'] = 'jsonc',
  },
  pattern = {
    ['tsconfig*.json'] = 'jsonc',
    ['.*/%.vscode/.*%.json'] = 'jsonc',
  },
}
