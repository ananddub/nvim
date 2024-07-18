return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },

    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "eslint-lsp",
                "lua-language-server",
                "tailwindcss-language-server",
                "typescript-language-server",
                "stylua",
                "clangd",
                "html-lsp",
                "css-lsp",
                "prettierd",
            },
        },
    },
    -- {
    --     'edluffy/hologram.nvim'
    -- },
    {
        "nvim-treesitter/nvim-treesitter",

        opts = {
            dependencies = {
                { "windwp/nvim-ts-autotag" },
            },
            autotag = { enable = true },
            autopairs = { enable = true },
            ensure_installed = {
                "vim",
                "vimdoc",
                "html",
                "css",
                "bash",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "cpp",
                "tsx",
                "typescript",
                "vim",
                "yaml",
            },
        },
    },
    {
        "windwp/nvim-ts-autotag",
        ft = {
            "typescript",
            "javascript",
            "javascriptreact",
            "typescriptreact",
            "html",
        },
    },
    { "terrortylor/nvim-comment" },
    { "mfussenegger/nvim-dap" },
    {
        "akinsho/flutter-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
        config = function()
            require("flutter-tools").setup {
                -- (uncomment below line for windows only)
                -- flutter_path = "home/flutter/bin/flutter.bat",

                debugger = {
                    -- make these two params true to enable debug mode
                    enabled = false,
                    run_via_dap = false,
                    register_configurations = function(_)
                        require("dap").adapters.dart = {
                            type = "executable",
                            command = vim.fn.stdpath "data" .. "/mason/bin/dart-debug-adapter",
                            args = { "flutter" },
                        }

                        require("dap").configurations.dart = {
                            {
                                type = "dart",
                                request = "launch",
                                name = "Launch flutter",
                                dartSdkPath = "home/flutter/bin/cache/dart-sdk/",
                                flutterSdkPath = "home/flutter",
                                program = "${workspaceFolder}/lib/main.dart",
                                cwd = "${workspaceFolder}",
                            },
                        }
                        -- uncomment below line if you've launch.json file already in your vscode setup
                        -- require("dap.ext.vscode").load_launchjs()
                    end,
                },
                dev_log = {
                    -- toggle it when you run without DAP
                    enabled = false,
                    open_cmd = "tabedit",
                },
                lsp = {
                    on_attach = require("lvim.lsp").common_on_attach,
                    capabilities = require("lvim.lsp").default_capabilities,
                },
            }
        end,
    },
    -- for dart syntax hightling
    {
        "dart-lang/dart-vim-plugin",
    },
    -- lazy.nvim
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    }
}
