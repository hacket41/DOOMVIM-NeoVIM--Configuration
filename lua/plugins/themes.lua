-- ~/.config/nvim/lua/plugins/themes.lua
return {
  {
    'shaunsingh/nord.nvim',
    priority = 1000,
    lazy = false,
    init = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = true
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false
      vim.cmd 'colorscheme nord'
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    lazy = false,
  },

  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    lazy = false,
  },

  {
    'nyoom-engineering/oxocarbon.nvim',
    name = 'oxocarbon',
    priority = 1000,
    lazy = false,
  },

  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    lazy = false,
  },

  {
    'diegoulloao/neofusion.nvim',
    priority = 1000,
    lazy = false,
  },

  {
    'kepano/flexoki-neovim',
    name = 'flexoki',
    priority = 1000,
    lazy = false,
  },

  {
    'sainnhe/sonokai',
    priority = 1000,
    lazy = false,
  },

  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    lazy = false,
  },

  {
    'maxmx03/dracula.nvim',
    priority = 1000,
    lazy = false,
  },

  {
    'xero/miasma.nvim',
    priority = 1000,
    lazy = false,
  },

  {
    'yorumicolors/yorumi.nvim',
    priority = 1000,
    lazy = false,
  },

  {
    'mhartington/oceanic-next',
    priority = 1000,
    lazy = false,
  },

  {
    'scottmckendry/cyberdream.nvim',
    priority = 1000,
    lazy = false,
  },

  {
    'Shatur/neovim-ayu',
    priority = 1000,
    lazy = false,
  },
}
