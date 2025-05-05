local ignored_filetypes = {
  ['qf'] = true,
  ['netrw'] = true,
  ['NvimTree'] = true,
  ['lazy'] = true,
  ['mason'] = true,
  ['oil'] = true,
  ['harpoon'] = true,
  ['spectre_panel'] = true,
  ['grug-far'] = true,
  ['grug-far-history'] = true,
  ['grug-far-help'] = true,
  ['NeogitPopup'] = true,
  ['NeogitStatus'] = true,
  ['codecompanion'] = true,
}

return {
  {
    'olimorris/persisted.nvim',
    lazy = false, -- make sure the plugin is always loaded at startup
    opts = {
      use_git_branch = true,
      should_save = function()
        -- Do not save if the alpha dashboard is the current filetype
        if ignored_filetypes[vim.bo.filetype] then
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
            if ignored_filetypes[vim.bo[buf].filetype] then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end
        end,
      })
    end,
    keys = function()
      return {
        {
          '<leader>sr',
          '<cmd>SessionLoad<CR>',
          { desc = '[S]ession [R]estore' },
        },
        {
          '<leader>ss',
          '<cmd>Telescope persisted<CR>',
          { desc = '[S]ession [S]elect' },
        },
      }
    end,
  },
}
