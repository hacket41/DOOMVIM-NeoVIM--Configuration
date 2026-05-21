return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope.nvim',
  },

  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- ASCII Art Header
    dashboard.section.header.val = {
      [[   ⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀ ██████╗  ██████╗  ██████╗ ███╗   ███╗██╗   ██╗██╗███╗   ███╗   ⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀]],
      [[ ⢀⣾⣿⣿⣿⣿⣿⣿⣏⣹⣿⣿⣿⣿⣿⣿⣷⡀ ██╔══██╗██╔═══██╗██╔═══██╗████╗ ████║██║   ██║██║████╗ ████║ ⢀⣾⣿⣿⣿⣿⣿⣿⣏⣹⣿⣿⣿⣿⣿⣿⣷⡀⠀]],
      [[⠈⢻⣿⠋⠉⠉⠉⠉⠉⣿⣿⠉⠉⠉⠉⠉⠙⣿⡟ ██║  ██║██║   ██║██║   ██║██╔████╔██║██║   ██║██║██╔████╔██║⠈⢻⣿⠋⠉⠉⠉⠉⠉⣿⣿⠉⠉⠉⠉⠉⠙⣿⡟ ]],
      [[ ⠈⠻⣷⣤⣀⣀⣀⣴⣿⣿⣦⣀⣀⣀⣤⣾⡟⠁ ██║  ██║██║   ██║██║   ██║██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╔╝██║ ⠈⠻⣷⣤⣀⣀⣀⣴⣿⣿⣦⣀⣀⣀⣤⣾⡟⠁ ]],
      [[   ⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀  ██████╔╝╚██████╔╝╚██████╔╝██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚═╝ ██║   ⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀  ]],
      [[    ⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋    ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝     ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝⠀   ⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀]],
      [[     ⢹⣿⣿⠀⠀⠀⠀⣿⣿⡿     ____________________________________________________________     ⢹⣿⣿⠀⠀⠀⠀⣿⣿⡿⠀⠀⠀⠀⠀]],
      [[     ⠸⣿⣿⠀⠀⠀⠀⣿⣿⡇⠀                          VILLANOUS NEOVIM                           ⠸⣿⣿⠀⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀]],
      [[      ⢿⣿⡆⠀⠀⠀⣿⡿      ____________________________________________________________      ⢿⣿⡆⠀⠀⠀⣿⡿⠀⠀⠀⠀⠀⠀]],
    }

    -- Dashboard Buttons
    -- Dashboard Buttons
    dashboard.section.buttons.val = {
      dashboard.button('g', '󰱼  Find Word (Live Grep)', ':Telescope live_grep<CR>'),
      dashboard.button('s', '  Settings (.config/nvim)', ':e ~/.config/nvim<CR>'),
      dashboard.button('t', '󰏘  Switch Theme', ":lua require('plugins.colortheme').select_theme()<CR>"),
      dashboard.button('r', '󰦛  Restore Last Session', "<cmd>lua require('persistence').load({ last = true })<CR>"),
      dashboard.button('c', '󰋚  Restore CWD Session', "<cmd>lua require('persistence').load()<CR>"),
      dashboard.button('d', '󰅖  Don’t Save Session', "<cmd>lua require('persistence').stop()<CR>"),
      dashboard.button('q', '󰗼  Quit Neovim', ':qa<CR>'),
    }

    -- Make all button icons same color (monochrome)
    for _, btn in ipairs(dashboard.section.buttons.val) do
      btn.opts.hl = 'Normal'
      btn.opts.hl_shortcut = 'Normal'
    end

    -- Footer
    dashboard.section.footer.val = ' hacket41 on Arch-Linux'

    -- Final Setup
    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end,
}
