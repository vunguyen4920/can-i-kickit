return {
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function() dofile(vim.g.base46_cache .. 'todo') end,
    opts = { signs = false },
    keys = {
      ---@diagnostic disable-next-line: undefined-field
      { '<leader>st', function() Snacks.picker.todo_comments() end, desc = '[S]earch [T]odo' },
    },
  },
}
