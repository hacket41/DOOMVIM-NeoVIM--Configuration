return {
  'numToStr/Comment.nvim',

  config = function()
    local comment = require 'Comment'

    comment.setup()

    local api = require 'Comment.api'
    local opts = { noremap = true, silent = true }

    -- NORMAL MODE
    vim.keymap.set('n', '<C-_>', api.toggle.linewise.current, opts)
    vim.keymap.set('n', '<C-/>', api.toggle.linewise.current, opts)
    vim.keymap.set('n', '<C-c>', api.toggle.linewise.current, opts)

    -- VISUAL MODE (NO visualmode(), NO nil possible)
    vim.keymap.set('v', '<C-_>', function()
      api.call('toggle.linewise', 'g@')
    end, opts)

    vim.keymap.set('v', '<C-/>', function()
      api.call('toggle.linewise', 'g@')
    end, opts)

    vim.keymap.set('v', '<C-c>', function()
      api.call('toggle.linewise', 'g@')
    end, opts)
  end,
}
