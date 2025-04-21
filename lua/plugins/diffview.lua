return {
  {
    'sindrets/diffview.nvim',
    event = 'BufReadPost',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    opts = {
      enhanced_diff_hl = true,
    },
    keys = {
      {
        '<leader>gh',
        '<cmd>DiffviewFileHistory %<CR>',
        desc = 'Git Diffview Current File [H]istory',
      },
    },
  },
}
