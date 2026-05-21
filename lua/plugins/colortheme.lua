local M = {}

local theme_file = vim.fn.stdpath 'cache' .. '/theme.txt'
local current_theme = 'tokyonight-night'
local bg_transparent = false

local themes = {
  'tokyonight-night',
  'tokyonight-storm',
  'tokyonight-moon',
  'catppuccin-mocha',
  'catppuccin-frappe',
  'catppuccin-macchiato',
  'kanagawa-wave',
  'kanagawa-dragon',
  'kanagawa-lotus',
  'nord',
  'oxocarbon',
  'gruvbox',
  'neofusion',
  'flexoki',
  'sonokai-andromeda',
  'sonokai-maia',
  'sonokai-shusia',
  'nightfox',
  'carbonfox',
  'nordfox',
  'duskfox',
  'terafox',
  'dracula',
  'miasma',
  'yorumi',
  'oceanic-next',
  'cyberdream',
  'ayu-dark',
  'ayu-light',
  'ayu-mirage',
  'melange',
  'vague',
  'rusty',
}

local function read_theme()
  local f = io.open(theme_file, 'r')
  if f then
    local name = f:read '*l'
    f:close()
    if name then
      current_theme = name
    end
  end
end

local function save_theme()
  local f = io.open(theme_file, 'w')
  if f then
    f:write(current_theme)
    f:close()
  end
end

local function apply_theme(name)
  current_theme = name
  vim.cmd 'hi clear'

  -- TOKYONIGHT
  if name:match '^tokyonight%-(.+)$' then
    local style = name:match '^tokyonight%-(.+)$'
    require('tokyonight').setup {
      style = style,
      transparent = bg_transparent,
    }
    vim.cmd('colorscheme ' .. name)

  -- CATPPUCCIN
  elseif name:match '^catppuccin%-(.+)$' then
    require('catppuccin').setup {
      transparent_background = bg_transparent,
    }
    vim.cmd('colorscheme ' .. name)

  -- KANAGAWA
  elseif name:match '^kanagawa%-(.+)$' then
    require('kanagawa').setup {
      transparent = bg_transparent,
    }
    vim.cmd('colorscheme ' .. name)

  -- NORD
  elseif name == 'nord' then
    vim.g.nord_disable_background = bg_transparent
    vim.cmd 'colorscheme nord'

  -- OXOCARBON
  elseif name == 'oxocarbon' then
    vim.g.oxocarbon_lua = true
    vim.cmd 'colorscheme oxocarbon'

  -- GRUVBOX
  elseif name == 'gruvbox' then
    vim.cmd 'colorscheme gruvbox'

  -- NEOFUSION
  elseif name == 'neofusion' then
    vim.o.background = 'dark'
    vim.cmd 'colorscheme neofusion'

  -- FLEXOKI
  elseif name == 'flexoki' then
    vim.cmd 'colorscheme flexoki-dark'

  -- SONOKAI
  elseif name:match '^sonokai%-(.+)$' then
    vim.g.sonokai_style = name:match '^sonokai%-(.+)$'
    vim.cmd 'colorscheme sonokai'

  -- NIGHTFOX FAMILY
  elseif vim.tbl_contains({
    'nightfox',
    'carbonfox',
    'duskfox',
    'nordfox',
    'terafox',
  }, name) then
    vim.cmd('colorscheme ' .. name)

  -- DRACULA
  elseif name == 'dracula' then
    vim.cmd 'colorscheme dracula'

  -- MIASMA
  elseif name == 'miasma' then
    vim.cmd 'colorscheme miasma'

  -- YORUMI
  elseif name == 'yorumi' then
    vim.cmd 'colorscheme yorumi'

  -- OCEANIC
  elseif name == 'oceanic-next' then
    vim.cmd 'colorscheme OceanicNext'

  -- CYBERDREAM
  elseif name == 'cyberdream' then
    vim.cmd 'colorscheme cyberdream'

  -- AYU
  elseif name:match '^ayu%-(.+)$' then
    local variant = name:match '^ayu%-(.+)$'
    vim.o.background = (variant == 'light') and 'light' or 'dark'
    require('ayu').setup {
      mirage = variant == 'mirage',
      overrides = {},
    }
    vim.cmd 'colorscheme ayu'

  -- MELANGE
  elseif name == 'melange' then
    vim.cmd 'colorscheme melange'

  -- VAGUE
  elseif name == 'vague' then
    vim.cmd 'colorscheme vague'

  -- RUSTY
  elseif name == 'rusty' then
    vim.cmd 'colorscheme rusty'
  end

  save_theme()
end

function M.select_theme()
  local has_telescope, telescope = pcall(require, 'telescope')
  if not has_telescope then
    vim.notify('Telescope is not installed!', vim.log.levels.ERROR)
    return
  end

  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  pickers
    .new({}, {
      prompt_title = 'Select Theme',
      finder = finders.new_table {
        results = themes,
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection then
            apply_theme(selection[1])
          end
        end)
        return true
      end,
    })
    :find()
end

function M.toggle_transparency()
  bg_transparent = not bg_transparent
  apply_theme(current_theme)
end

function M.current_theme()
  vim.notify('Current theme: ' .. (vim.g.colors_name or 'unknown'))
end

vim.schedule(function()
  read_theme()
  apply_theme(current_theme)
end)

vim.keymap.set('n', '<leader>bg', M.toggle_transparency, { desc = 'Toggle transparency' })
vim.keymap.set('n', '<leader>ct', M.select_theme, { desc = 'Choose color theme' })
vim.keymap.set('n', '<leader>cs', M.current_theme, { desc = 'Show current theme' })

return M
