return {
  {
    'stevearc/aerial.nvim',
    cmd = { 'AerialToggle', 'AerialNext', 'AerialPrev' },
    keys = {
      { '<leader>ae', '<cmd>AerialToggle<cr>', desc = 'Toggle Aerial' },
    },
    opts = {
      backends = { 'lsp', 'treesitter', 'markdown', 'asciidoc', 'man' },
      show_guides = true,
      layout = {
        resize_to_content = true,
        win_opts = {
          winhl = 'Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB',
        },
      },
      guides = {
        mid_item = '├╴',
        last_item = '└╴',
        nested_top = '│ ',
        whitespace = '  ',
      },
      filter_kind = {
        'Class',
        'Constructor',
        'Enum',
        'Field',
        'Function',
        'Interface',
        'Method',
        'Module',
        'Namespace',
        'Package',
        'Property',
        'Struct',
        'Trait',
      },
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
}
