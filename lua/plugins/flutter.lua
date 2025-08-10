return {
  'akinsho/flutter-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional, for better UI
  },
  config = function()
    require('flutter-tools').setup {
      flutter_path = 'flutter', -- assumes flutter is in your PATH
      lsp = {
        on_attach = function(_, bufnr)
          local map = vim.keymap.set
          local opts = { buffer = bufnr }
          map('n', 'gd', vim.lsp.buf.definition, opts)
          map('n', 'K', vim.lsp.buf.hover, opts)
          map('n', '<leader>rn', vim.lsp.buf.rename, opts)
        end,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      },
    }
  end,
}
