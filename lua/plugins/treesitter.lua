return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
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
        'luadoc',
        'markdown',
        'markdown_inline',
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
        'vue',
        'xml',
        'yaml',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function()
      dofile(vim.g.base46_cache .. 'syntax')
      dofile(vim.g.base46_cache .. 'treesitter')
    end,
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPost',
  },
  {
    'andersevenrud/nvim_context_vt',
    opts = {},
    config = function()
      require('nvim_context_vt').setup()
    end,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'BufReadPost',
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      multiline_threshold = 1,
    },
    config = function(_, opts)
      require('treesitter-context').setup(opts)
    end,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'BufReadPost',
    keys = {
      {
        '<leader>tc',
        '<cmd>TSContextToggle<CR>',
        desc = 'Treesitter Context Toggle',
      },
    },
  },
  {
    'davidmh/mdx.nvim',
    event = 'BufRead *.mdx',
    config = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  { 'fei6409/log-highlight.nvim', event = 'BufRead *.log', opts = {} },
}
