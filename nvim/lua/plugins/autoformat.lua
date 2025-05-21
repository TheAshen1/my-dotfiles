return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>gf",
            function()
                require("conform").format({ async = true })
            end,
            mode = "",
            desc = "Format",
        },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            c = { "clang-format" },
            json = { "clang-format" },
            cs = { "csharpier" },
        },
        formatters = {
            csharpier = {
                command = "csharpier",
                args = { "format" },
            },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = { timeout_ms = 500 },
    },
}
