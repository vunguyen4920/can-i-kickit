return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    init = function()
      dofile(vim.g.base46_cache .. 'syntax')
      dofile(vim.g.base46_cache .. 'treesitter')
    end,
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    config = function()
      local parsers = {
        'angular',
        'arduino',
        'astro',
        'bash',
        'c',
        'clojure',
        'cpp',
        'css',
        'csv',
        'comment',
        'devicetree',
        'diff',
        'dockerfile',
        'editorconfig',
        'gdscript',
        'gdshader',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'graphql',
        'groovy',
        'html',
        'http',
        'java',
        'javadoc',
        'javascript',
        'jsdoc',
        'json',
        'json5',
        'jsx',
        'kotlin',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'mermaid',
        'prisma',
        'python',
        'query',
        'regex',
        'robots_txt',
        'ruby',
        'rust',
        'scss',
        'sql',
        'styled',
        'svelte',
        'tsx',
        'typescript',
        'udev',
        'vim',
        'vimdoc',
        'vue',
        'xml',
        'yaml',
        'zsh',
      }
      require('nvim-treesitter').install(parsers)
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then return end

          -- check if parser exists and load it
          if not vim.treesitter.language.add(language) then return end
          -- enables syntax highlighting and other treesitter features
          vim.treesitter.start(buf, language)

          -- enables treesitter based folds
          -- for more info on folds see `:help folds`
          -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          -- vim.wo.foldmethod = 'expr'

          -- enables treesitter based indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'BufReadPost',
    branch = 'main',
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true

      -- Or, disable per filetype (add as you like)
      -- vim.g.no_python_maps = true
      -- vim.g.no_ruby_maps = true
      -- vim.g.no_rust_maps = true
      -- vim.g.no_go_maps = true
    end,
  },
  {
    'andersevenrud/nvim_context_vt',
    event = 'BufReadPre',
    opts = {},
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufReadPre',
    opts = {
      multiline_threshold = 1,
      max_lines = 3,
      min_window_height = 20,
    },
  },
  {
    'davidmh/mdx.nvim',
    event = 'BufRead *.mdx',
    config = true,
  },
  { 'fei6409/log-highlight.nvim', event = 'BufRead *.log', opts = {} },
}
