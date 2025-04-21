local map = vim.keymap.set

map('n', '<leader>zz', '<cmd>LspRestart<cr>', { desc = 'Hey, Sleep [zz]zzzz, wake up' })

-- mark then join then back to the mark
map('n', 'J', 'mzJ`z')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
map('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
map('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
map('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
map('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- greatest remap ever
-- unnecessary stuff to the void
map('x', '<leader>p', [["_dP]])

map('n', '<leader>me', '<cmd>set mouse=a<CR>', { desc = 'Mouse Enable' })
map('n', '<leader>md', '<cmd>set mouse=<CR>', { desc = 'Mouse Disable' })
map('i', 'jk', '<ESC>', { desc = '<ESC> Escape Insert mode' })

-- Formatter
map('n', '<leader>fme', ':FormatEnable<CR>')
map('n', '<leader>fmd', ':FormatDisable<CR>')

map('n', '<leader>ft', ':echo &filetype<CR>', { desc = 'Show current filetype' })

map('n', '<C-w>C', ":exe (v:count ? v:count : '') . 'tabclose'<CR>", { desc = '[C]lose current tab' })
map('n', '<C-w>O', ":exe (v:count ? v:count : '') . 'tabonly'<CR>", { desc = 'Keep [O]nly other tab' })

-- Set column numbers
map('n', '<leader>n', '<cmd>set nu!<CR>', { desc = 'toggle line number' })
map('n', '<leader>rn', '<cmd>set rnu!<CR>', { desc = 'toggle relative number' })
