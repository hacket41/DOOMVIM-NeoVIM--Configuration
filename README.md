# DOOMVIM — NeoVim Configuration

A personal, from-scratch Neovim configuration built with [lazy.nvim](https://github.com/folke/lazy.nvim), targeting **Neovim v0.12**. It's designed to be fast, modular, and easy to extend — every feature lives in its own file, so you can enable, disable, or tweak plugins without wading through one giant config.

You're welcome to use this repo as-is, or fork it as a starting point for your own setup. If you're new to Neovim configuration in general, [LazyVim's starter template](https://github.com/LazyVim/starter) is also a great reference.

## Features

- **Lazy-loaded plugins** via `lazy.nvim` for fast startup times
- **File explorer** with `neo-tree`
- **Fuzzy finding** with `telescope`
- **Syntax highlighting & parsing** via `treesitter`
- **LSP support** with autocompletion (`nvim-cmp` / blink-style setup) and linting/formatting via `none-ls`
- **Git integration** with `gitsigns` and `neogit`
- **Buffer/tab line** via `bufferline`
- **Statusline** via `lualine`
- **Dashboard/start screen** via `alpha`
- **Indent guides** via `indent-blankline`
- **Session persistence** via `persistence`
- **AI code completion** via `codium`
- **Diagnostics/quickfix UI** via `trouble`
- **Language-specific tooling**: Flutter, Java, C/C++, and REST client support
- **Custom colorscheme** module for easy theme switching

## Project Structure

```
.
├── init.lua              # Entry point — loads core config, bootstraps lazy.nvim, loads plugins
├── colors.lua             # Colorscheme definitions/overrides
├── lazy-lock.json          # Locked plugin versions (managed by lazy.nvim)
├── .stylua.toml            # Lua formatting rules (used by StyLua)
└── lua/
    ├── core/
    │   ├── options.lua      # Neovim options (UI, editing behavior, etc.)
    │   ├── keymaps.lua      # Global keybindings
    │   ├── snippets.lua     # Snippet configuration
    │   └── autocmds.lua     # Autocommands
    └── plugins/
        ├── neotree.lua
        ├── themes.lua
        ├── bufferline.lua
        ├── lualine.lua
        ├── treesitter.lua
        ├── telescope.lua
        ├── lsp.lua
        ├── autocompletion.lua
        ├── none-ls.lua
        ├── gitsigns.lua
        ├── alpha.lua
        ├── indent-blankline.lua
        ├── misc.lua
        ├── comment.lua
        ├── persistence.lua
        ├── flutter.lua
        ├── codium.lua
        ├── java.lua
        ├── rest.lua
        ├── trouble.lua
        ├── neogit.lua
        ├── c_cpp.lua
        └── colortheme.lua
```

`init.lua` is intentionally thin — it wires up `core/` (options, keymaps, snippets, autocommands), bootstraps `lazy.nvim` if it isn't installed yet, and then loads every plugin module from `lua/plugins/`.

## Requirements

- **Neovim >= 0.12**
- **Git** (for cloning `lazy.nvim` and plugins)
- A [Nerd Font](https://www.nerdfonts.com/) installed and configured in your terminal (for icons in `neo-tree`, `lualine`, `bufferline`, etc.)
- `ripgrep` and `fd` (recommended, for `telescope` fuzzy finding)
- A C compiler (e.g. `gcc`/`clang`) for `treesitter` parser compilation
- Language servers / tooling for whichever languages you work with (installable via `:Mason` if included, or manually)

## Installation

> ️ Back up your existing Neovim config first if you have one.

1. **Clone the repo into your Neovim config directory:**

   ```bash
   git clone https://github.com/hacket41/DOOMVIM-NeoVIM--Configuration.git ~/.config/nvim
   ```

2. **Launch Neovim:**

   ```bash
   nvim
   ```

   On first launch, `lazy.nvim` will automatically bootstrap itself and install all configured plugins. This may take a minute — just let it finish.

3. **Run health checks** to confirm everything is set up correctly:

   ```vim
   :checkhealth
   ```

## ⌨️ Usage

- Plugin management: `:Lazy` — install, update, clean, or profile plugins
- LSP/formatter/linter management: `:Mason` (if configured)
- File explorer: toggle with your configured `neo-tree` keymap
- Fuzzy find files/text: your configured `telescope` keymaps
- Diagnostics list: `:Trouble` or its keymap
- Git panel: `:Neogit`

> See `lua/core/keymaps.lua` for the full list of custom keybindings.

## Customization

- **Colorscheme:** edit `colors.lua` and `lua/plugins/colortheme.lua`
- **Editor behavior:** edit `lua/core/options.lua`
- **Keybindings:** edit `lua/core/keymaps.lua`
- **Add/remove plugins:** create or edit a file in `lua/plugins/` and require it from `init.lua`
- **Formatting rules for the config itself:** see `.stylua.toml` (run `stylua .` to format)

## Plugin Versions

`lazy-lock.json` pins every plugin to a specific commit for reproducibility. If you update plugins with `:Lazy update`, make sure to commit the updated lock file.

## Acknowledgements

Inspired by the Doom Emacs / Doom Nvim philosophy of a curated, modular, "your system, your rules" configuration, and by the broader Neovim Lua config community (LazyVim, NvChad, AstroNvim, and others).

## License

No license specified yet — consider adding one (e.g. MIT) if you'd like others to freely reuse this config.
