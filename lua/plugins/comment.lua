-- Easily comment visual regions/lines
return {
  'numToStr/Comment.nvim',
  -- Do NOT use both opts = {} and config = function() together.
  -- opts = {} triggers the default setup; config overrides it entirely.
  config = function()
    require('Comment').setup()

    local opts = { noremap = true, silent = true }

    -- Normal mode: toggle current line
    vim.keymap.set('n', '<C-_>', require('Comment.api').toggle.linewise.current, opts)
    vim.keymap.set('n', '<C-c>', require('Comment.api').toggle.linewise.current, opts)
    vim.keymap.set('n', '<C-/>', require('Comment.api').toggle.linewise.current, opts)

    -- Visual mode: toggle selection
    vim.keymap.set('v', '<C-_>', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
    vim.keymap.set('v', '<C-c>', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
    vim.keymap.set('v', '<C-/>', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
  end,
}
