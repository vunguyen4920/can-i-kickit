return {
  {
    'esmuellert/codediff.nvim',
    cmd = 'CodeDiff',
    keys = {
      {
        '<leader>g.',
        '<cmd>CodeDiff history %<CR>',
        desc = '[G]it History Current File ("." for repeat)',
      },
      {
        '<leader>gh',
        '<cmd>CodeDiff history<CR>',
        desc = '[G]it [H]istory',
      },
    },
  },
}
