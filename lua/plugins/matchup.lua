return {
  {
    'andymass/vim-matchup',
    lazy = false,
    opts = function()
      require('nvim-treesitter.configs').setup {
        matchup = {
          enable = true, -- mandatory, false will disable the whole extension
        },
      }

      vim.g.matchup_matchparen_offscreen = { method = 'popup', fullwidth = 1, syntax_hl = 1 }
      vim.g.matchup_matchparen_deferred = 1

      return {}
    end,
  },
}
