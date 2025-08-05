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

    -- Create Folder Button (aligned and opens folder)
    local create_folder_button = {
      type = 'button',
      val = '📂  Create Folder',
      on_press = function()
        local folder = vim.fn.input 'Folder name: '
        if folder ~= '' then
          vim.fn.mkdir(folder, 'p')
          print('📂 Created folder: ' .. folder)
          local escaped = vim.fn.fnameescape(folder)
          vim.cmd('Neotree reveal dir=' .. escaped)
        else
          print '⚠️ Cancelled: No folder name given'
        end
      end,
      opts = {
        position = 'center',
        shortcut = 'n',
        cursor = 3, -- aligns with other buttons
        width = 40,
        align_shortcut = 'right',
        hl = 'Normal',
        hl_shortcut = 'Keyword',
      },
    }

    -- Dashboard Buttons
    dashboard.section.buttons.val = {
      dashboard.button('f', '📁  Open Folder', ':Neotree toggle<CR>'),
      dashboard.button('g', '🔍  Find Word (Live Grep)', ':Telescope live_grep<CR>'),
      dashboard.button('t', '🎨  Switch Theme', ":lua require('plugins.colortheme').cycle_theme()<CR>"),
      dashboard.button('s', '⚙️  Settings (.config/nvim)', ':e ~/.config/nvim<CR>'),
      dashboard.button('q', '❌  Quit Neovim', ':qa<CR>'),
      dashboard.button('r', '   Restore Last Session', "<cmd>lua require('persistence').load({ last = true })<CR>"),
      dashboard.button('s', '   Restore CWD Session', "<cmd>lua require('persistence').load()<CR>"),
      dashboard.button('d', "   Don't Save Session", "<cmd>lua require('persistence').stop()<CR>"),
      create_folder_button,
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
