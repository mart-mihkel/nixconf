return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")

        telescope.setup()
        telescope.load_extension("fzf")

        vim.keymap.set("n", "<leader>sr", builtin.resume)
        vim.keymap.set("n", "<leader>so", builtin.oldfiles)
        vim.keymap.set("n", "<leader>sg", builtin.live_grep)
        vim.keymap.set("n", "<leader>sG", builtin.git_files)
        vim.keymap.set("n", "<leader>sf", builtin.find_files)
    end,
}
