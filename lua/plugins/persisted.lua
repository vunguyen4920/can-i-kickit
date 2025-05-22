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

return {
  {
    'olimorris/persisted.nvim',
    lazy = false, -- make sure the plugin is always loaded at startup
    opts = {
      use_git_branch = true,
      should_save = function()
        -- Do not save if the alpha dashboard is the current filetype
        if vim.tbl_contains(ignored_filetypes, vim.bo.filetype) then
          return false
        end

        return true
      end,
    },
    config = function(_, opts)
      require('persisted').setup(opts)
      require('telescope').setup {
        extensions = {
          persisted = {
            layout_config = { width = 0.55, height = 0.55 },
          },
        },
      }

      vim.api.nvim_create_autocmd('User', {
        pattern = 'PersistedSavePre',
        callback = function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.tbl_contains(ignored_filetypes, vim.api.nvim_get_option_value('filetype', { buf = buf })) then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end
        end,
      })
    end,
    keys = function()
      return {
        {
          '<leader>ss',
          '<cmd>SessionLoad<CR>',
          { desc = '[S]ession Re[s]tore' },
        },
      }
    end,
  },
}
