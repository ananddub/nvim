local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        tsx = { "stylua" },
        ts = { "stylua" },
        jsx = { "stylua" },
        js = { "stylua" },
        c = { "stylua" },
        java = { "stylua" },
        json = { "stylua" },
        toml = { "stylua" },
        css = { "prettier" },
        html = { "prettier" },
        cpp = { "clang-format" },
    },

    format_on_save = {
        --   - These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

require("conform").setup(options)
