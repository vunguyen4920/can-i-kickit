local map = vim.keymap.set

-- mark then join then back to the mark
map('n', 'J', 'mzJ`z')

map('n', '<leader>zz', ':e<CR>', { desc = '[zz]zzzz, wake up, wake up' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- greatest remap ever
-- unnecessary stuff to the void
map('x', '<leader>p', [["_dP]])
map({ 'n', 'v' }, '<leader>d', '"_d')

map('n', '<leader>me', '<cmd>set mouse=a<CR>', { desc = '[M]ouse [E]nable' })
map('n', '<leader>md', '<cmd>set mouse=<CR>', { desc = '[M]ouse [D]isable' })

-- Formatter
map('n', '<leader>fme', ':FormatEnable<CR>')
map('n', '<leader>fmd', ':FormatDisable<CR>')

map('n', '<leader>ft', ':echo &filetype<CR>', { desc = 'Show current [F]ile[T]ype' })

map('n', '<C-w>Q', ":exe (v:count ? v:count : '') . 'tabclose'<CR>", { desc = '[Q]uit current tab', silent = true })
map('n', '<C-w>O', ":exe (v:count ? v:count : '') . 'tabonly'<CR>", { desc = 'Keep [O]nly this tab', silent = true })

-- Set column numbers
map('n', '<leader>n', '<cmd>set nu!<CR>', { desc = 'toggle line [N]umber' })
map('n', '<leader>rn', '<cmd>set rnu!<CR>', { desc = 'toggle [R]elative [N]umber' })

-- Vietnamese keymap
map('n', '<leader>kv', '<cmd>set keymap=vietnamese-telex_utf-8<CR>', { desc = 'Set [V]ietnamese [K]eymap' })
map('n', '<leader>kn', '<cmd>set keymap=""<CR>', { desc = 'Set [N]ormal [K]eymap' })

-- Keeping the cursor centered.
map('n', 'n', 'nzzzv', { desc = 'Next result' })
map('n', 'N', 'Nzzzv', { desc = 'Previous result' })

-- never know that i would need this
map('n', '<leader>cx', '<cmd>!chmod +x %<CR>', { silent = true })
