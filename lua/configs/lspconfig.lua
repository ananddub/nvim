-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    }
end

-- typescript
lspconfig.tsserver.setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
}
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

require("nvim-treesitter.configs").setup {
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
}

-- load the colorscheme here
--

local on_attachc = function(client, bufnr)
    client.server_capabilities.server_capabilities = false
    on_attach(client, bufnr)
end

local capabilitiesc = vim.lsp.protocol.make_client_capabilities()

lspconfig.clangd.setup {
    on_attach = on_attachc,
    capabilities = capabilities,
}
lspconfig.pyright.setup {
    on_attach = on_attachc,
    capabilities = capabilities,
}
-- require('hologram').setup {
--     auto_display = true -- WIP automatic markdown image display, may be prone to breaking
-- }
-- require("noice").setup({
--     lsp = {
--         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
--         override = {
--             ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--             ["vim.lsp.util.stylize_markdown"] = true,
--             ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
--         },
--     },
--     -- you can enable a preset for easier configuration
--     presets = {
--         bottom_search = true,         -- use a classic bottom cmdline for search
--         command_palette = true,       -- position the cmdline and popupmenu together
--         long_message_to_split = true, -- long messages will be sent to a split
--         inc_rename = false,           -- enables an input dialog for inc-rename.nvim
--         lsp_doc_border = false,       -- add a border to hover docs and signature help
--     },
-- })
--
require("notify").setup({
    background_colour = "#000000",
})
