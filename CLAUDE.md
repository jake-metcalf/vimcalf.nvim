# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration using lazy.nvim for plugin management. The config supports multiple languages: Python, TypeScript/JavaScript, Lua, Go, Terraform, Svelte, and Markdown.

## Architecture

```
init.lua              → requires("jake")
lua/jake/init.lua     → loads set.lua, remap.lua, lazy_init.lua (in order)
lua/jake/lazy/*.lua   → individual plugin specs (auto-imported by lazy.nvim)
```

**Key files:**
- `lua/jake/set.lua` - Vim options, autocmds, global functions
- `lua/jake/remap.lua` - All keybindings (leader is Space)
- `lua/jake/lazy_init.lua` - lazy.nvim bootstrap
- `lua/jake/lazy/lsp.lua` - LSP servers, completion (nvim-cmp), and formatting (conform.nvim)

## Plugin Pattern

Each plugin config in `lua/jake/lazy/` returns a lazy.nvim spec table:
```lua
return {
    "author/plugin-name",
    dependencies = { ... },
    opts = { ... },
    config = function() ... end,
}
```

Multiple related plugins can be returned as a table of specs.

## Formatting

Lua files use stylua (configured in `.stylua.toml`): 4-space indent, 160 column width, no call parentheses.

Auto-format on save is enabled via conform.nvim for all supported languages.

## Keybinding Conventions

Mnemonic prefixes under `<leader>`:
- `f` - Find/Files (picker operations)
- `g` - Git operations
- `l` - LSP operations
- `s` - Search/grep
- `t` - Testing
- `o` - Oil file browser
- `m` - Markdown
- `z` - Zen mode

## LSP Servers

Configured in `lazy/lsp.lua` via mason-lspconfig: basedpyright, lua_ls, ts_ls, gopls, marksman, html, terraformls, svelte.

## Testing

Uses vim-test with vimux. Keybinds: `<leader>tn` (nearest), `<leader>tf` (file), `<leader>ta` (all), `<leader>tl` (last).
