return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
        completion = {
            accept = { auto_brackets = { enabled = false } },
            menu = {
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind" },
                    },
                },
            },
        },
    },
    opts_extend = { "sources.default" },
}
