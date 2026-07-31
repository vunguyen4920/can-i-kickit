return {
  {
    'ph1losof/ecolog2.nvim',
    lazy = false,
    build = 'cargo install ecolog-lsp',
    keys = {
      { '<leader>el', '<cmd>Ecolog list<cr>', desc = 'List env variables' },
      { '<leader>ef', '<cmd>Ecolog files select<cr>', desc = 'Select env file' },
      { '<leader>eo', '<cmd>Ecolog files open_active<cr>', desc = 'Open active env file' },
      { '<leader>er', '<cmd>Ecolog refresh<cr>', desc = 'Refresh env variables' },
    },
    opts = {},
  },
}
