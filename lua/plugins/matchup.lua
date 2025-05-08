return {
  {
    'andymass/vim-matchup',
    event = 'BufEnter',
    opts = function()
      require('nvim-treesitter.configs').setup {
        matchup = {
          enable = true, -- mandatory, false will disable the whole extension
        },
      }

      vim.g.matchup_matchparen_offscreen = { method = 'popup' }

      return {}
    end,
  },
}
