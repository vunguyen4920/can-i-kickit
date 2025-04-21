return {
  {
    'eandrju/cellular-automaton.nvim',
    cmd = { 'CellularAutomaton' },
    keys = {
      {
        '<leader>fml',
        '<cmd>CellularAutomaton make_it_rain<CR>',
        mode = '',
        desc = '[F] [M]y [L]ife',
      },
      {
        '<leader>wtf',
        '<cmd>CellularAutomaton game_of_life<CR>',
        mode = '',
        desc = '[W]ut [T]he [F]',
      },
    },
  },
}
