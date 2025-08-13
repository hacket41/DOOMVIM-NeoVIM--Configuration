-- lua/plugins/c_cpp.lua
return {
  'hacket41/c_cpp',  -- optional name placeholder
  dependencies = { 'neovim/nvim-lspconfig', 'hrsh7th/nvim-cmp' },
  config = function()
    -- safely load lspconfig
    local ok, lspconfig = pcall(require, 'lspconfig')
    if not ok then
      vim.notify('nvim-lspconfig not found!', vim.log.levels.ERROR)
      return
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend(
      'force',
      capabilities,
      require('cmp_nvim_lsp').default_capabilities()
    )

    -- clangd setup
    lspconfig.clangd.setup {
      capabilities = capabilities,
      filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
      cmd = { 'clangd', '--background-index' },
      on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- LSP keymaps
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

        -- Compile & run C/C++ file
        vim.keymap.set('n', '<leader>fc', function()
          local file = vim.fn.expand '%:p'
          local dir = vim.fn.expand '%:p:h'
          local filename = vim.fn.expand '%:t:r'
          local ext = vim.fn.expand '%:e'

          local cmd = ''
          if ext == 'c' then
            cmd = string.format("gcc '%s' -o '%s/%s' && '%s/%s'", file, dir, filename, dir, filename)
          elseif ext == 'cpp' then
            cmd = string.format("g++ '%s' -o '%s/%s' && '%s/%s'", file, dir, filename, dir, filename)
          else
            print 'Not a C or C++ file.'
            return
          end

          vim.cmd('split term://' .. cmd)
        end, { noremap = true, silent = true, desc = 'Compile & run C/C++ file' })
      end,
    }

    -- Treat .h files as C++
    vim.cmd [[
      autocmd BufRead,BufNewFile *.h set filetype=cpp
    ]]
  end,
}
