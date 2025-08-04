-- ~/.config/nvim/lua/plugins/themes.lua

return {
  -- Nord theme
  {
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
  },

  -- Catppuccin theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
  },

  -- Tokyo Night theme
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
  },
}
