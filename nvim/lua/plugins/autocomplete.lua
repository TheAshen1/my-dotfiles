return {
    "saghen/blink.cmp",
    enabled = true,
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = "default" },
        cmdline = { enabled = false },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
        },
    },
    opts_extend = { "sources.default" },
}
