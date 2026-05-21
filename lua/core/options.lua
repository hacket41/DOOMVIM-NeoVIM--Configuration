vim.wo.number = true           -- Make line numbers default (default: false)
vim.o.relativenumber = true    -- Set relative numbered lines (default: false)
vim.o.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim. (default: '')
vim.o.wrap = false             -- Display lines as one long line (default: true)
vim.o.linebreak = true         -- Companion to wrap, don't split words (default: false)
vim.o.mouse = 'a'              -- Enable mouse mode (default: '')
vim.o.autoindent = true        -- Copy indent from current line when starting new one (default: true)
vim.o.ignorecase = true        -- Case-insensitive searching UNLESS \C or capital in search (default: false)
vim.o.smartcase = true         -- Smart case (default: false)
vim.o.shiftwidth = 2           -- Spaces per indentation level (2 is more universal for most languages)
vim.o.tabstop = 2              -- Visual width of a tab character
vim.o.softtabstop = 2          -- Spaces inserted/deleted per tab press
vim.o.expandtab = true         -- Convert tabs to spaces (default: false)
vim.o.scrolloff = 4            -- Minimal number of screen lines to keep above and below the cursor (default: 0)
vim.o.sidescrolloff = 8        -- Minimal number of screen columns either side of cursor if wrap is `false` (default: 0)
vim.o.cursorline = false       -- Highlight the current line (default: false)
vim.o.splitbelow = true        -- Force all horizontal splits to go below current window (default: false)
vim.o.splitright = true        -- Force all vertical splits to go to the right of current window (default: false)
vim.o.hlsearch = false         -- Set highlight on search (default: true)
vim.o.showmode = false         -- We don't need to see things like -- INSERT -- anymore (default: true)
vim.opt.termguicolors = true   -- Set termguicolors to enable highlight groups (default: false)
vim.o.whichwrap = 'bs<>[]hl'  -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')
vim.o.numberwidth = 4          -- Set number column width to 2 {default 4} (default: 4)
vim.o.swapfile = false         -- Creates a swapfile (default: true)
vim.o.smartindent = true       -- Make indenting smarter again (default: false)
vim.o.showtabline = 2          -- Always show tabs (default: 1)
vim.o.backspace = 'indent,eol,start' -- Allow backspace on (default: 'indent,eol,start')
vim.o.pumheight = 10           -- Pop up menu height (default: 0)
vim.o.conceallevel = 0         -- So that `` is visible in markdown files (default: 1)
vim.wo.signcolumn = 'yes'      -- Keep signcolumn on by default (default: 'auto')
vim.o.fileencoding = 'utf-8'   -- The encoding written to a file (default: 'utf-8')
vim.o.cmdheight = 1            -- More space in the Neovim command line for displaying messages (default: 1)
vim.o.breakindent = true       -- Enable break indent (default: false)
vim.o.updatetime = 250         -- Decrease update time (default: 4000)
vim.o.timeoutlen = 300         -- Time to wait for a mapped sequence to complete (in milliseconds) (default: 1000)
vim.o.backup = false           -- Creates a backup file (default: false)
vim.o.writebackup = false      -- If a file is being edited by another program (default: true)
vim.o.undofile = true          -- Save undo history (default: false)
vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience (default: 'menu,preview')
vim.opt.shortmess:append 'c'   -- Don't give |ins-completion-menu| messages (default: does not include 'c')
vim.opt.iskeyword:append '-'   -- Hyphenated words recognized by searches (default: does not include '-')
vim.opt.formatoptions:remove { 'c', 'r', 'o' } -- Don't insert comment leader automatically
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles' -- Separate Vim plugins from Neovim
vim.o.foldenable = false

-- Per-filetype indent overrides using autocommands
-- This ensures correct indentation for every language regardless of treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'json', 'html', 'css', 'scss', 'vue', 'svelte', 'yaml', 'toml', 'tsx', 'jsx' },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python', 'rust', 'go', 'java', 'c', 'cpp', 'c_sharp', 'lua', 'dart' },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'makefile', 'make' },
  callback = function()
    -- Go and Makefiles require real tabs
    vim.bo.expandtab = false
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
  end,
})
