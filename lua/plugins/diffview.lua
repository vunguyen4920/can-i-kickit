return {
  {
    'sindrets/diffview.nvim',
    event = 'BufReadPost',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    init = function()
      dofile(vim.g.base46_cache .. 'diffview')
    end,
    opts = function()
      return {
        default_args = { DiffviewFileHistory = { '%' } },
        enhanced_diff_hl = true,
      }
    end,
    keys = {
      {
        '<leader>gh',
        '<cmd>DiffviewFileHistory<CR>',
        desc = 'Git Diffview Current File [H]istory',
      },
    },
  },
}
