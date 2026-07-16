return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local function lualine_theme()
      local cs = vim.g.colors_name
      if not cs then
        return 'auto'
      end

      -- flavors
      if cs:find 'catppuccin' then
        return cs
      end
      if cs:find 'tokyonight' then
        return cs
      end
      if cs:find 'kanagawa' then
        return cs
      end

      -- direct mappings
      local map = {
        nord = 'nord',
        gruvbox = 'gruvbox',
        oxocarbon = 'oxocarbon',
        melange = 'melange',
        vague = 'vague',
        ayu = 'ayu',
        miasma = 'miasma',
        sonokai = 'sonokai',
        nightfox = 'nightfox',
        dracula = 'dracula',
        cyberdream = 'cyberdream',
        oceanicnext = 'oceanicnext',
        neofusion = 'neofusion',
        flexoki = 'flexoki',
        poimandres = 'poimandres',
      }

      return map[cs] or 'auto'
    end

    local mode = {
      'mode',
      fmt = function(str)
        return ' ' .. str
      end,
    }

    local filename = {
      'filename',
      file_status = true,
      path = 0,
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      colored = false,
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      'diff',
      colored = false,
      symbols = { added = ' ', modified = ' ', removed = ' ' },
      cond = hide_in_width,
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = lualine_theme(), -- ✅ auto theme
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'neo-tree' },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { 'branch' },
        lualine_c = { filename },
        lualine_x = {
          diagnostics,
          diff,
          { 'encoding', cond = hide_in_width },
          { 'filetype', cond = hide_in_width },
        },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'fugitive' },
    }

    --  refresh when colorscheme changes
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        require('lualine').setup {
          options = { theme = lualine_theme() },
        }
        require('lualine').refresh()
      end,
    })
  end,
}
