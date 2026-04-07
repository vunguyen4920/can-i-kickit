-- See the kickstart.nvim README for more information
return {
  { 'NMAC427/guess-indent.nvim', event = 'BufEnter', opts = {} }, -- Detect tabstop and shiftwidth automatically
  {
    'lewis6991/spaceless.nvim',
    opts = {},
    event = 'BufReadPost',
  },
  {
    'mvllow/modes.nvim',
    tag = 'v0.2.1',
    event = 'BufEnter',
    opts = {},
  },
  {
    'axelvc/template-string.nvim',
    event = 'BufEnter',
    opts = {
      remove_template_string = true,
    },
  },
}
