vim.filetype.add {
  extension = {
    kbd = 'clojure',
    keymap = 'dts',
  },
  filename = {
    ['.eslintrc.json'] = 'jsonc',
  },
  pattern = {
    ['tsconfig*.json'] = 'jsonc',
    ['.*/%.vscode/.*%.json'] = 'jsonc',
  },
}
