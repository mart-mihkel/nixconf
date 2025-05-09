return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "saghen/blink.cmp",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        vim.diagnostic.config({
            virtual_lines = { current_line = true },
        })

        vim.lsp.config("*", {
            root_markers = { ".git" },
            capabilities = require("blink.cmp").get_lsp_capabilities({
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    },
                },
            }),
        })

        require("mason").setup()
        require("mason-lspconfig").setup({ automatic_enable = { exclude = { "ruff" } } })
    end,
}
