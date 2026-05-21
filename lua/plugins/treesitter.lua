return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  opts = {
    ensure_installed = {
      'lua',
      'python',
      'javascript',
      'typescript',
      'vimdoc',
      'vim',
      'regex',
      'terraform',
      'sql',
      'dockerfile',
      'toml',
      'json',
      'java',
      'groovy',
      'go',
      'gitignore',
      'graphql',
      'yaml',
      'make',
      'cmake',
      'markdown',
      'markdown_inline',
      'bash',
      'tsx',
      'css',
      'c_sharp',
      'html',
      'c',
      'cpp',
      'rust',
      'ruby',
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = {
      enable = true,
    },
  },
  config = function(_, opts)
    -- nvim-treesitter v1.x: setup() accepts opts directly
    require('nvim-treesitter').setup(opts)

    -- nvim-ts-autotag: guard against nil buf_parser crash
    require('nvim-ts-autotag').setup {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
      per_filetype = {
        ['html'] = { enable_close = true },
        ['jsx'] = { enable_close = true },
        ['tsx'] = { enable_close = true },
        ['xml'] = { enable_close = true },
        ['php'] = { enable_close = true },
        ['vue'] = { enable_close = true },
        ['svelte'] = { enable_close = true },
        ['javascript'] = { enable_close = true },
        ['typescript'] = { enable_close = true },
        ['javascriptreact'] = { enable_close = true },
        ['typescriptreact'] = { enable_close = true },
      },
    }
  end,
}
-- There are additional nvim-treesitter modules that you can use to interact
-- with nvim-treesitter. You should go explore a few and see what interests you:
--
--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
