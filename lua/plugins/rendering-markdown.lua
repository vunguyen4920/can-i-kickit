return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'codecompanion', 'mcphub' },
    branch = 'main',
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      file_types = { 'markdown', 'codecompanion', 'mcphub' },
      preset = 'obsidian',
      completions = {
        lsp = { enabled = true },
        blink = { enabled = true },
      },
    },
    dependencies = {
      'saghen/blink.cmp',
    },
  },
}
