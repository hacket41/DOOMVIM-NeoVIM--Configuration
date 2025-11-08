return {
  {
    'seblyng/roslyn.nvim',
    ft = { 'cs', 'razor', 'cshtml' },
    dependencies = {
      'williamboman/mason.nvim',
      {
        'tris203/rzls.nvim',
        config = true,
      },
    },
    config = function()
      local roslyn = require 'roslyn'
      roslyn.setup {
        on_attach = function(_, bufnr)
          local opts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        end,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      }
    end,
  },
}
