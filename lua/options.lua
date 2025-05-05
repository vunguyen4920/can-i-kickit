local o, g = vim.o, vim.g

-- See `:help mapleader`
g.mapleader = ' '
g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
g.have_nerd_font = true

-- [[ Setting oions ]]
-- See `:help o`
--  For more oions, you can see `:help option-list`
o.number = true
o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this oion if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)

-- Enable break indent
o.breakindent = true

o.smartindent = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

-- Save undo history
o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
o.ignorecase = true
o.smartcase = true

-- Keep signcolumn on by default
o.signcolumn = 'yes'

-- Decrease update time
o.updatetime = 100

-- Decrease mapped sequence wait time
o.timeoutlen = 300

-- Configure how new splits should be opened
o.splitright = true
o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
o.list = true

-- TODO: Use vim.o when it supports this syntax
---See: https://github.com/neovim/neovim/issues/20107
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
o.inccommand = 'split'

-- Show which line your cursor is on
o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
o.confirm = true

o.wrap = false

o.colorcolumn = '80'

o.termguicolors = true

o.laststatus = 3
