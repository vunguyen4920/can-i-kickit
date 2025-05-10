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

      return {}
    end,
  },
}
