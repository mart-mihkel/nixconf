return {
    {
        "shaunsingh/nord.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.nord_disable_background = true
            vim.cmd.colorscheme("nord")
        end,
    },
    { "neanias/everforest-nvim" },
    { "ellisonleao/gruvbox.nvim" },
    { "rose-pine/neovim", name = "rose-pine" },
}
