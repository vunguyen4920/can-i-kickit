return {
  {
    'sindrets/diffview.nvim',
    event = 'BufReadPost',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    opts = function()
      dofile(vim.g.base46_cache .. 'diffview')

      return {
        enhanced_diff_hl = true,
      }
    end,
    keys = {
      {
        '<leader>gh',
        '<cmd>DiffviewFileHistory %<CR>',
        desc = 'Git Diffview Current File [H]istory',
      },
    },
  },
}
