return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    init = function()
      dofile(vim.g.base46_cache .. 'syntax')
      dofile(vim.g.base46_cache .. 'treesitter')
    end,
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'css',
        'diff',
        'dockerfile',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'graphql',
        'groovy',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'json5',
        'jsonc',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'norg',
        'prisma',
        'query',
        'regex',
        'scss',
        'svelte',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'vue',
        'xml',
        'yaml',
      },
      auto_install = true,
      highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gnn',
          node_incremental = 'grn',
          scope_incremental = 'grc',
          node_decremental = 'grm',
        },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'BufReadPost',
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
