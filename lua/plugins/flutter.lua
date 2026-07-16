return {
  'akinsho/flutter-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
  },
  config = function()
    require('flutter-tools').setup {
      flutter_path = '/home/hacket41/Development/flutter/bin/flutter',

      lsp = {
        cmd = {
          '/home/hacket41/Development/flutter/bin/dart',
          'language-server',
          '--protocol=lsp',
        },

        on_attach = function(_, bufnr)
          local map = vim.keymap.set
          local opts = { buffer = bufnr, silent = true }

          map('n', 'gd', vim.lsp.buf.definition, opts)
          map('n', 'K', vim.lsp.buf.hover, opts)
          map('n', '<leader>rn', vim.lsp.buf.rename, opts)
          map('n', '<leader>ca', vim.lsp.buf.code_action, opts)

          local augroup = vim.api.nvim_create_augroup('DartFormatting', { clear = false })
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }

          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false, bufnr = bufnr }
            end,
          })
        end,

        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      },

      widget_guides = {
        enabled = true,
      },
    }
  end,
}
