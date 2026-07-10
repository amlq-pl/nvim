return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- Installs non-LSP tools (formatters, linters) declaratively via Mason
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- Extends LSP capabilities so completion supports snippets + auto-imports
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- 1. Mason installs every external tool automatically on first launch,
    --    so a fresh clone of this repo is a one-click setup.
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "texlab", -- LaTeX
        "vtsls",  -- TypeScript/JavaScript/React (wraps VS Code's TS server)
        "eslint", -- Lint diagnostics + quick fixes for JS/TS projects
        "clangd", -- C/C++ (completion, diagnostics, navigation; reads compile_commands.json)
      },
    })
    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier",     -- Formatter for JS/TS/JSX/JSON/CSS/HTML
        "clang-format", -- Formatter for C/C++
      },
    })

    -- 2. Advertise nvim-cmp capabilities to every server.
    --    Required for snippet completions and auto-imports to work.
    vim.lsp.config("*", {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })

    -- Show errors/warnings as inline virtual text (VS Code style).
    -- Neovim 0.11 turned this off by default.
    vim.diagnostic.config({ virtual_text = true })

    -- 3. TexLab: detect the OS to pick the right PDF viewer
    local os_name = (vim.uv or vim.loop).os_uname().sysname
    local forward_search_config = {}

    if os_name == "Darwin" then
      -- Mac Skim arguments
      forward_search_config = {
        executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
        args = { "-g", "%l", "%p", "%f" },
      }
    elseif os_name == "Linux" then
      -- Ubuntu Zathura arguments
      forward_search_config = {
        executable = "zathura",
        args = { "--synctex-forward", "%l:1:%f", "%p" },
      }
    end

    vim.lsp.config("texlab", {
      settings = {
        texlab = {
          build = { onSave = true },
          forwardSearch = forward_search_config,
        },
      },
    })

    -- 4. vtsls: VS Code-equivalent TypeScript/React experience
    --    (auto-imports, update imports on file rename, function-call completions)
    vim.lsp.config("vtsls", {
      settings = {
        complete_function_calls = true,
        vtsls = {
          enableMoveToFileCodeAction = true,
          -- Prefer the TypeScript version from the project's node_modules,
          -- exactly like VS Code does
          autoUseWorkspaceTsdk = true,
          experimental = {
            completion = { enableServerSideFuzzyMatch = true },
          },
        },
        typescript = {
          updateImportsOnFileMove = { enabled = "always" },
          suggest = { completeFunctionCalls = true },
          inlayHints = {
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = false },
            functionLikeReturnTypes = { enabled = true },
          },
        },
        javascript = {
          updateImportsOnFileMove = { enabled = "always" },
          suggest = { completeFunctionCalls = true },
        },
      },
    })

    -- 5. ESLint: pick up the project's eslint config automatically,
    --    including monorepos with nested configs
    vim.lsp.config("eslint", {
      settings = {
        workingDirectories = { mode = "auto" },
      },
    })

    -- 6. clangd: full C/C++ IDE experience for large CMake projects.
    --    It reads compile_commands.json (generate it once per project with
    --    `cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ...`, or symlink build/compile_commands.json
    --    into the project root) so it knows every include path and flag.
    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--background-index",             -- index the whole project in the background
        "--background-index-priority=normal",
        "--clang-tidy",                   -- inline clang-tidy lint diagnostics
        "--header-insertion=iwyu",        -- auto-insert #include when completing symbols
        "--completion-style=detailed",    -- richer completion items (VS Code style)
        "--function-arg-placeholders",    -- fill in argument placeholders on call completion
        "--fallback-style=llvm",          -- format style when no .clang-format is present
        "--pch-storage=memory",           -- faster reparse on big projects (uses more RAM)
        "-j=8",                           -- parallel indexing workers
        "--query-driver=/usr/bin/**/clang-*,/usr/bin/**/*-gcc,/usr/bin/**/*-g++",
      },
      -- Anchor the workspace root so a single clangd instance covers the whole project.
      root_markers = {
        "compile_commands.json",
        "compile_flags.txt",
        ".clangd",
        ".clang-format",
        "CMakeLists.txt",
        ".git",
      },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
    })

    vim.lsp.enable({ "texlab", "vtsls", "eslint", "clangd" })
  end,
}
