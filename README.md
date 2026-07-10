# nvim

Personal Neovim setup. Everything is declared in code — clone the repo, open
Neovim once, and all plugins, language servers, and tools install themselves.

## Setup

1. Install the prerequisites (see below).
2. Clone this repo to your Neovim config directory:

   ```sh
   git clone <this-repo> ~/.config/nvim
   ```

3. Start `nvim`. On first launch, lazy.nvim bootstraps itself and installs all
   plugins, Mason downloads the language servers and formatters, and
   Tree-sitter compiles its parsers. No manual steps.

### Prerequisites

- **Neovim 0.11+**
- **git** — plugin installation
- **Node.js 18+** and **npm** — required by the TypeScript language server
  (`vtsls`), ESLint, and Prettier
- **A C compiler** (clang/gcc) — Tree-sitter parser compilation
- *(LaTeX only)* A TeX distribution with `latexmk`/`latexindent`, plus Skim
  (macOS) or Zathura (Linux) as the PDF viewer

## Language support

### TypeScript / JavaScript / React

Powered by [`vtsls`](https://github.com/yioneko/vtsls), which wraps the same
TypeScript language service used by VS Code, so the experience matches VS Code:

- **Autocompletion with auto-imports** — accepting a completion inserts the
  missing `import` automatically
- **Find all references, go to definition/implementation/type definition**
- **Rename symbol** across the project
- **Quick fixes & refactors** via code actions (add missing import, remove
  unused, move to file, ...)
- **Update imports on file rename/move**
- **ESLint** diagnostics with quick fixes (via the ESLint language server,
  using your project's own eslint config — monorepo-aware)
- **Prettier** formatting on save (via conform.nvim)
- **Inlay hints** for parameter names and return types (toggle with
  `<leader>th`)

The project's own TypeScript version from `node_modules` is preferred over the
bundled one, exactly like VS Code.

### LaTeX

`texlab` + VimTeX with build-on-save and forward search (Skim on macOS,
Zathura on Linux — detected automatically).

## Key bindings

Leader key is `<Space>`.

| Key | Action | VS Code equivalent |
| --- | --- | --- |
| `gd` | Go to definition | `F12` |
| `gr` | Find all references | `Shift+F12` |
| `gi` | Go to implementation | `Cmd+F12` |
| `gy` | Go to type definition | — |
| `K` | Hover documentation | mouse hover |
| `<leader>rn` | Rename symbol | `F2` |
| `<leader>ca` | Code action / quick fix | `Cmd+.` |
| `<leader>cf` | Format file | `Shift+Alt+F` |
| `<leader>q` | List all diagnostics | Problems panel |
| `]d` / `[d` | Next / previous diagnostic | `F8` |
| `<leader>th` | Toggle inlay hints | — |
| `<leader>sf` | Find files | `Cmd+P` |
| `<leader>sg` | Live grep | `Cmd+Shift+F` |
| `<leader>sb` | Find open buffers | — |
| `<leader>sc` | Find git changes (hunks) in current buffer | — |
| `<leader>gs` | Git status: pick from modified/added/deleted files | Source Control panel |
| `<C-s>` | Save file | `Cmd+S` |

Completion (insert mode): `<C-Space>` trigger, `<C-j>`/`<C-k>` navigate,
`<CR>` confirm.

## Structure

```
init.lua                    -- bootstraps lazy.nvim, loads config + plugins
lua/config/options.lua      -- editor options
lua/config/keymaps.lua      -- global + LSP keymaps
lua/plugins/lsp.lua         -- Mason + language servers (vtsls, eslint, texlab)
lua/plugins/cmp.lua         -- completion engine + snippets
lua/plugins/formatting.lua  -- conform.nvim (prettier, latexindent)
lua/plugins/treesitter.lua  -- syntax highlighting parsers
lua/plugins/...             -- mini.nvim modules, colorscheme, vimtex
```

Every plugin file in `lua/plugins/` is auto-loaded by lazy.nvim. All external
tools (language servers, formatters) are declared in `ensure_installed` lists
and installed by Mason on startup — nothing needs to be installed by hand.
