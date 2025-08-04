local M = {}

local current_theme = 'nord'
local bg_transparent = true

local function apply_theme(name)
  current_theme = name
  vim.cmd 'hi clear' -- reset highlights

  if name == 'nord' then
    vim.g.nord_contrast = true
    vim.g.nord_borders = false
    vim.g.nord_disable_background = bg_transparent
    vim.g.nord_italic = false
    vim.g.nord_uniform_diff_background = true
    vim.g.nord_bold = false
    vim.cmd 'colorscheme nord'
  elseif name == 'catppuccin' then
    require('catppuccin').setup {
      transparent_background = bg_transparent,
      flavour = 'mocha',
    }
    vim.cmd 'colorscheme catppuccin'
  elseif name == 'tokyonight' then
    require('tokyonight').setup {
      transparent = bg_transparent,
      style = 'storm',
    }
    vim.cmd 'colorscheme tokyonight'
  end
end

-- Custom tbl_indexof function to find index in table
local function tbl_indexof(tbl, val)
  for i, v in ipairs(tbl) do
    if v == val then
      return i
    end
  end
  return nil
end

function M.cycle_theme()
  local themes = { 'nord', 'catppuccin', 'tokyonight' }
  local idx = tbl_indexof(themes, current_theme) or 1
  local next_theme = themes[(idx % #themes) + 1]
  apply_theme(next_theme)
  vim.notify('Switched to ' .. next_theme, vim.log.levels.INFO)
end

function M.toggle_transparency()
  bg_transparent = not bg_transparent
  apply_theme(current_theme)
  vim.notify('Transparency: ' .. (bg_transparent and 'On' or 'Off'), vim.log.levels.INFO)
end

-- Delayed initial theme load
vim.schedule(function()
  apply_theme(current_theme)
end)

vim.keymap.set('n', '<leader>bg', M.toggle_transparency, { desc = 'Toggle transparency' })
vim.keymap.set('n', '<leader>ct', M.cycle_theme, { desc = 'Cycle color theme' })

return M
