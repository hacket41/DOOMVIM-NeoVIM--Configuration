return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- Formatters & linters for mason to install
    require('mason-null-ls').setup {
      ensure_installed = {
        'prettier', -- ts/js/html/css/json/yaml formatter
        'prettierd', -- faster prettier daemon
        'eslint_d', -- ts/js linter
        'shfmt', -- Shell formatter
        'csharpier', -- C# formatter
        'checkmake', -- linter for Makefiles
        -- 'stylua', -- lua formatter; Already installed via Mason
        -- 'ruff', -- Python linter and formatter; Already installed via Mason
      },
      automatic_installation = true,
    }

    local sources = {
      -- Linters
      diagnostics.checkmake,

      -- eslint_d is in none-ls-extras, not builtins
      require('none-ls.diagnostics.eslint_d').with {
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte' },
      },

      -- TypeScript / JavaScript / Web: prettierd for fast formatting
      formatting.prettierd.with {
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'vue',
          'svelte',
          'css',
          'scss',
          'less',
          'html',
          'json',
          'jsonc',
          'yaml',
          'markdown',
          'graphql',
        },
        -- Respect project-level .prettierrc / prettier.config.js
        prefer_local = 'node_modules/.bin',
      },

      -- Dart / Flutter
      formatting.dart_format.with {
        command = '/home/hacket41/Development/flutter/bin/dart',
      },

      -- Lua
      formatting.stylua,

      -- Shell
      formatting.shfmt.with { args = { '-i', '4' } },

      -- Terraform
      formatting.terraform_fmt,

      -- Python
      require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
      require 'none-ls.formatting.ruff_format',
    }

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,
      on_attach = function(client, bufnr)
        if client:supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format {
                async = false,
                -- Prefer none-ls over tsserver so prettierd wins on TS/JS files
                filter = function(c)
                  return c.name == 'null-ls'
                end,
              }
            end,
          })
        end
      end,
    }
  end,
}
