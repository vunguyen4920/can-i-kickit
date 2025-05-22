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
        enabled = true,
        sections = {
          {
            section = 'terminal',
            pane = 1,
            cmd = 'tock -m -c; sleep .1',
            hl = 'header',
            padding = 0,
          },
          {
            section = 'terminal',
            pane = 1,
            cmd = "curl 'wttr.in/?0QFp&lang=vi'; sleep .1",
            hl = 'header',
            indent = 6,
          },
          { section = 'header', pane = 2, gap = 1, padding = 1 },
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
      -- rename on oil actions
      vim.api.nvim_create_autocmd('User', {
        pattern = 'OilActionsPost',
        callback = function(event)
          if event.data.actions.type == 'move' then
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
          end
        end,
      })

      -- on empty show dashboard
      vim.api.nvim_create_autocmd('BufDelete', {
        group = vim.api.nvim_create_augroup('dashboard_on_empty', { clear = true }),
        callback = function(args)
          vim.schedule(function()
            local ignored_filetypes = {
              'qf',
              'netrw',
              'NvimTree',
              'lazy',
              'mason',
              'harpoon',
              'spectre_panel',
              'grug-far',
              'grug-far-history',
              'grug-far-help',
              'NeogitPopup',
              'NeogitStatus',
              'codecompanion',
              'checkhealth',
              'trouble',
              'aerial',
            }
            if vim.tbl_contains(ignored_filetypes, vim.api.nvim_get_option_value('filetype', { buf = args.buf })) then
              return
            end

            local deleted_name = vim.api.nvim_buf_get_name(args.buf)
            local deleted_ft = vim.api.nvim_get_option_value('filetype', { buf = args.buf })
            local dashboard_on_empty = (deleted_name == '' and deleted_ft == '')
              or (vim.api.nvim_buf_get_name(0) == '' and vim.api.nvim_get_option_value('filetype', { buf = 0 }) == '')
            if dashboard_on_empty then
              ---@diagnostic disable-next-line: missing-fields
              Snacks.dashboard { buf = 0, win = 0 }
            end
          end)
        end,
      })
    end,
  },
}
