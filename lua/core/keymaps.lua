-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ':bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- For running flutter projects
vim.keymap.set('n', '<leader>fr', ':!flutter run<CR>', { noremap = true, silent = true, desc = 'Run Flutter project' })

-- For running C/C++ projects

-- Compile & run C/C++ file
-- Compile & run C/C++ file
vim.keymap.set('n', '<leader>fc', function()
  local file = vim.fn.expand '%:p' -- full path of current file
  local filepath = vim.fn.expand '%:p:h' -- directory of the file
  local filename = vim.fn.expand '%:t:r' -- file name without extension
  local ext = vim.fn.expand '%:e'

  local cmd = ''
  if ext == 'c' then
    cmd = string.format("gcc '%s' -o '%s/%s' && '%s/%s'", file, filepath, filename, filepath, filename)
  elseif ext == 'cpp' then
    cmd = string.format("g++ '%s' -o '%s/%s' && '%s/%s'", file, filepath, filename, filepath, filename)
  else
    print 'Not a C or C++ file.'
    return
  end

  vim.cmd('split term://' .. cmd) -- run in a split terminal
end, { noremap = true, silent = true, desc = 'Compile & run C/C++ file' })

-- For C# Dotnet

vim.keymap.set('n', '<leader>fs', function()
  -- get current directory
  local cwd = vim.fn.expand '%:p:h'

  -- look for .csproj in folder
  local project_files = vim.fn.globpath(cwd, '*.csproj', false, true)

  if #project_files == 0 then
    print 'No .csproj project found in this folder.'
    return
  end

  -- use the first .csproj file
  local project = project_files[1]

  -- run the project
  local cmd = "dotnet run --project '" .. project .. "'"

  vim.cmd('split term://' .. cmd)
end, { noremap = true, silent = true, desc = 'Run C# .NET project' })

-- React Native
vim.keymap.set('n', '<leader>re', function()
  vim.cmd [[botright split | terminal zsh -lc 'npx expo start; exec zsh']]
end, { noremap = true, silent = true, desc = 'Run Expo project' })

-- rest.nvim keymaps
vim.keymap.set('n', '<leader>rr', '<Plug>RestNvim', { desc = 'Run REST request' })
vim.keymap.set('n', '<leader>rl', '<Plug>RestNvimLast', { desc = 'Re-run last request' })
vim.keymap.set('n', '<leader>rp', '<Plug>RestNvimPreview', { desc = 'Preview REST request' })
