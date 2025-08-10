local M = {}

local theme_file = vim.fn.stdpath 'cache' .. '/theme.txt'
local current_theme = 'tokyonight-night'
local bg_transparent = true

local themes = {
  'tokyonight-night',
  'tokyonight-storm',
  'tokyonight-moon',
  'catppuccin-latte',
  'catppuccin-frappe',
  'catppuccin-macchiato',
  'kanagawa-wave',
  'kanagawa-dragon',
  'kanagawa-lotus',
  'nord',
  'oxocarbon',
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

  if name:match '^tokyonight' then
    local style = name:match 'tokyonight%-(%a+)$' or 'storm'
    require('tokyonight').setup {
      style = style,
      transparent = bg_transparent,
    }
    vim.cmd 'colorscheme tokyonight'
  elseif name:match '^catppuccin' then
    local flavour = name:match 'catppuccin%-(%a+)$' or 'mocha'
    require('catppuccin').setup {
      flavour = flavour,
      transparent_background = bg_transparent,
    }
    vim.cmd 'colorscheme catppuccin'
  elseif name:match '^kanagawa' then
    local theme = name:match 'kanagawa%-(%a+)$' or 'wave'
    require('kanagawa').setup {
      theme = theme,
      transparent = bg_transparent,
    }
    vim.cmd 'colorscheme kanagawa'
  elseif name == 'nord' then
    vim.g.nord_disable_background = bg_transparent
    vim.cmd 'colorscheme nord'
  elseif name == 'oxocarbon' then
    -- Optional: enable Lua syntax tweaks
    vim.g.oxocarbon_lua = true
    vim.cmd 'colorscheme oxocarbon'
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
