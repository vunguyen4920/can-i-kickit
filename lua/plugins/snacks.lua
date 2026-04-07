return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    keys = {
      {
        '<leader>sh',
        function() Snacks.picker.help() end,
        desc = '[S]earch [H]elp',
      },
      {
        '<leader>sk',
        function() Snacks.picker.keymaps() end,
        desc = '[S]earch [K]eymaps',
      },
      {
        '<leader>sf',
        function()
          Snacks.picker.files {
            finder = 'files',
            format = 'file',
            show_empty = true,
            supports_live = true,
          }
        end,
        desc = '[S]earch [F]iles',
      },
      {
        '<leader>sc',
        function() Snacks.picker.commands() end,
        desc = '[S]earch [C]ommands',
      },
      {
        '<leader>sg',
        function() Snacks.picker.grep() end,
        desc = '[S]earch by [G]rep',
      },
      {
        '<leader>s/',
        function() Snacks.picker.grep() end,
        desc = '[S]earch by [G]rep',
      },
      {
        '<leader>sd',
        function() Snacks.picker.diagnostics() end,
        desc = '[S]earch [D]iagnostics',
      },
      {
        '<leader>sr',
        function() Snacks.picker.resume() end,
        desc = '[S]earch [R]esume',
      },
      {
        '<leader>s.',
        function() Snacks.picker.recent() end,
        desc = '[S]earch Recent Files ("." for repeat)',
      },
      {
        '<leader><space>',
        function() Snacks.picker.smart() end,
        desc = '[S]earch Smart',
      },
      {
        '<leader>sb',
        function() Snacks.picker.buffers() end,
        desc = '[S]earch [B]uffers',
      },
      {
        '<leader>sn',
        function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end,
        desc = '[S]earch [N]eovim Config',
      },
      { '<leader>su', function() Snacks.picker.undo() end, desc = '[S]earch [U]ndo' },
      { '<leader>tt', function() Snacks.terminal.toggle() end, desc = '[T]oggle [T]erminal' },
      { '<leader>gb', function() Snacks.picker.git_branches() end, desc = '[G]it [B]ranches' },
      { '<leader>gv', function() Snacks.gitbrowse() end, desc = '[G]it [V]isit Repo' },
    },
    ---@type snacks.Config
    opts = {
      bigfile = {},
      bufdelete = {},
      dashboard = {
        preset = {
          header = [[
  ______                                               ___
 /      \                                             |  \
|  ▓▓▓▓▓▓\ ______   ______  _______   ______   ______ | ▓▓
| ▓▓   \▓▓/      \ /      \|       \ /      \ /      \ \▓-
| ▓▓     |  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\  -
| ▓▓   __| ▓▓  | ▓▓ ▓▓   \▓▓ ▓▓  | ▓▓ ▓▓    ▓▓ ▓▓  | ▓▓  -
| ▓▓__/  \ ▓▓__/ ▓▓ ▓▓     | ▓▓  | ▓▓ ▓▓▓▓▓▓▓▓ ▓▓__/ ▓▓  -
 \▓▓    ▓▓\▓▓    ▓▓ ▓▓     | ▓▓  | ▓▓\▓▓     \\▓▓    ▓▓  -
  \▓▓▓▓▓▓  \▓▓▓▓▓▓ \▓▓      \▓▓   \▓▓ \▓▓▓▓▓▓▓ \▓▓▓▓▓▓   -
 ]],

          keys = {
            { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
            { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = ' ', key = 'b', desc = 'Git Branch', action = ":lua Snacks.dashboard.pick('git_branches')" },
            { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = ' ', key = 'v', desc = 'Visit Repo', action = ':lua Snacks.gitbrowse()' },
            { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
            { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },
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
      gitbrowse = {},
      image = { doc = { inline = false } },
      indent = { chunk = { enabled = true } },
      input = {},
      picker = {
        matcher = {
          history_bonus = true,
        },
      },
      rename = {},
      scope = {},
      scroll = {},
      statuscolumn = {},
      terminal = {},
    },
    init = function()
      -- rename on oil actions
      vim.api.nvim_create_autocmd('User', {
        pattern = 'OilActionsPost',
        callback = function(event)
          if event.data.actions.type == 'move' then Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url) end
        end,
      })

      -- on empty show dashboard
      vim.api.nvim_create_autocmd('BufDelete', {
        group = vim.api.nvim_create_augroup('dashboard_on_empty', { clear = true }),
        callback = function(args)
          local ignored_filetypes = {
            'NeogitPopup',
            'NeogitStatus',
            'NvimTree',
            'aerial',
            'checkhealth',
            'codediff-history',
            'grug-far',
            'grug-far-help',
            'grug-far-history',
            'harpoon',
            'lazy',
            'mason',
            'netrw',
            'qf',
            'spectre_panel',
            'trouble',
          }
          if vim.tbl_contains(ignored_filetypes, vim.api.nvim_get_option_value('filetype', { buf = args.buf })) then return end

          local deleted_name = vim.api.nvim_buf_get_name(args.buf)
          local deleted_ft = vim.api.nvim_get_option_value('filetype', { buf = args.buf })
          local dashboard_on_empty = (deleted_name == '' and deleted_ft == '')
            or (vim.api.nvim_buf_get_name(0) == '' and vim.api.nvim_get_option_value('filetype', { buf = 0 }) == '')
          if dashboard_on_empty then
            ---@diagnostic disable-next-line: missing-fields
            Snacks.dashboard { buf = 0, win = 0 }
          end
        end,
      })
    end,
  },
}
