return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      dashboard = {
        enable = true,
        sections = {
          {
            section = 'terminal',
            pane = 1,
            cmd = 'tock -m -c; sleep .1',
            hl = 'header',
            padding = 0,
            height = 25,
          },
          {
            section = 'terminal',
            pane = 2,
            cmd = "curl 'wttr.in/?0qFp&lang=vi'; sleep .1",
            hl = 'header',
            indent = 12,
          },
          { section = 'keys', pane = 2, gap = 1, padding = 1 },
          { section = 'startup', pane = 2 },
          {
            section = 'terminal',
            cmd = 'kingler random -iu --stats; sleep .1',
            random = 10,
            pane = 3,
            indent = 4,
            height = 30,
          },
        },
      },
      image = { enabled = false, doc = { inline = false } },
      indent = { enabled = true },
      input = { enabled = true },
      rename = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
    },
    init = function()
      local prev = { new_name = '', old_name = '' } -- Prevents duplicate events
      vim.api.nvim_create_autocmd('User', {
        pattern = 'NvimTreeSetup',
        callback = function()
          local events = require('nvim-tree.api').events
          events.subscribe(events.Event.NodeRenamed, function(data)
            if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
              data = data
              require('snacks').rename.on_rename_file(data.old_name, data.new_name)
            end
          end)
        end,
      })
    end,
  },
}
