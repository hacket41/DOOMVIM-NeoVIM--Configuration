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
}
