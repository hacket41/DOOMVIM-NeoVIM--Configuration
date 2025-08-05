return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- Load before opening files
  config = function()
    require('persistence').setup {
      dir = vim.fn.stdpath 'state' .. '/sessions/', -- Save session files here
      options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
    }
  end,
}
