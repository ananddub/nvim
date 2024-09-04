if vim.g.vscode then
    require('customvscode.vscode')
else
    vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"


    vim.g.mapleader = " "

    -- bootstrap lazy and all plugins
    local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

    if not vim.loop.fs_stat(lazypath) then
        local repo = "https://github.com/folke/lazy.nvim.git"
        vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
    end

    vim.opt.rtp:prepend(lazypath)

    local lazy_config = require "configs.lazy"

    -- load plugins
    require("lazy").setup({
        {
            "NvChad/NvChad",
            lazy = false,
            branch = "v2.5",
            import = "nvchad.plugins",
            config = function()
                require "options"
            end,
        },
        -- { "codota/tabnine-nvim", build = "./dl_binaries.sh" },

        { import = "plugins" },
    }, lazy_config)

    require('nvim-ts-autotag').setup({
        opts = {
            -- Defaults
            enable_close = true,          -- Auto close tags
            enable_rename = true,         -- Auto rename pairs of tags
            enable_close_on_slash = false -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
            ["html"] = {
                eenable_rename = true,
                enable_close_on_slash = false,
                nable_close = false
            },
            ["javascriptreact"] = {
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = false
            },
            ["typescriptreact"] = {
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = false
            },
        }
    })
    -- load theme
    dofile(vim.g.base46_cache .. "defaults")
    dofile(vim.g.base46_cache .. "statusline")

    require "nvchad.autocmds"

    vim.schedule(function()
        require "mappings"
    end)

    -- require("tabnine").setup {
    --     disable_auto_comment = true,
    --     accept_keymap = "<Tab>",
    --     dismiss_keymap = "<C-]>",
    --     debounce_ms = 800,
    --     suggestion_color = { gui = "#808080", cterm = 244 },
    --     exclude_filetypes = { "TelescopePrompt", "NvimTree" },
    --     log_file_path = nil, -- absolute path to Tabnine log file
    -- }

    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
            require("conform").format {
                timeout_ms = 500,
                lsp_fallback = true,
            }
        end,
    })
    local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
    }

    local hooks = require "ibl.hooks"
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    require("ibl").setup { indent = { highlight = highlight } }
    -- vim.g.loaded_node_provider = 1
    vim.g.loaded_python3_provider = 1
    -- vim.g.loaded_ruby_provider = 1
    -- vim.g.loaded_perl_provider = 1
    -- vim.g:python3_host_prog = '/usr/bin/python3'

    -- Transparent background ke liye settings false then
    require("nvim_comment").setup()

    -- Ensure promise-async is loaded before nvim-ufo
    -- require('promise-async')ufo
    -- require('ufo').setup({
    --     provider_selector = function(bufnr, filetype, buftype)
    --         return { 'treesitter', 'indent' }
    --     end
    -- })
    require("nvim-treesitter.configs").setup {
        -- ensure_installed = 'maintained',maintain
        highlight = {
            enable = true,
        },
        refactor = {
            highlight_definitions = {
                enable = true,
            },
            highlight_current_scope = {
                enable = true,
            },
            smart_rename = {
                enable = true,
                keymaps = {
                    smart_rename = "grr",
                },
            },
        },
        fold = {
            enable = true,
        },
    }
    vim.o.foldcolumn = '1' -- Add a fold column on the left
    vim.o.foldlevel = 99   -- Set high fold level to avoid folding everything by default
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true



    require("flutter-tools").setup {
        widget_guides = {
            enabled = true,
        },

    }

    ---
end
