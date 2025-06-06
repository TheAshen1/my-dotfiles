return {
    {
        "williamboman/mason.nvim",
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
            },
            ensure_installed = {
                -- C / C++
                "cpptools",
                "clangd",
                -- C#
                "roslyn",
                "csharpier",
                "netcoredbg",
                -- Lua
                "lua_ls",
            },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {},
    },
    {
        "neovim/nvim-lspconfig",
        opts = {},
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("custom.lsp", { clear = true }),
                callback = function(event)
                    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

                    vim.keymap.set("n", "<leader>gn", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename" })

                    vim.keymap.set(
                        { "n", "x" },
                        "<leader>ga",
                        vim.lsp.buf.code_action,
                        { buffer = event.buf, desc = "Code Action" }
                    )

                    vim.keymap.set(
                        "n",
                        "<leader>gD",
                        vim.lsp.buf.declaration,
                        { buffer = event.buf, desc = "Goto Declaration" }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>gr",
                        -- vim.lsp.buf.references,
                        require("telescope.builtin").lsp_references,
                        { buffer = event.buf, desc = "Goto References" }
                    )

                    vim.keymap.set(
                        "n",
                        "<leader>gi",
                        vim.lsp.buf.implementation,
                        -- require("telescope.builtin").lsp_implementations,
                        { buffer = event.buf, desc = "Goto Implementation" }
                    )

                    vim.keymap.set(
                        "n",
                        "<leader>gd",
                        vim.lsp.buf.type_definition,
                        -- require("telescope.builtin").lsp_definitions,
                        { buffer = event.buf, desc = "Goto Definition" }
                    )

                    vim.keymap.set(
                        "n",
                        "<leader>gt",
                        vim.lsp.buf.type_definition,
                        -- require("telescope.builtin").lsp_type_definitions,
                        { buffer = event.buf, desc = "Goto Type Definition" }
                    )

                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "Hover" })

                    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                        local highlight_augroup = vim.api.nvim_create_augroup("custom.lsp-highlight", { clear = false })

                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = vim.api.nvim_create_augroup("custom.lsp-detach", { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({ group = "custom.lsp-highlight", buffer = event2.buf })
                            end,
                        })
                    end
                end,
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                                vim.env.VIMRUNTIME .. "/lua",
                            },
                        },
                    },
                },
            })
            vim.lsp.enable("lua_ls")

            vim.lsp.enable("clangd")

            vim.lsp.config("roslyn", {
                on_attach = function()
                    print("Attached roslyn...")
                end,
                settings = {
                    ["csharp|background_analysis"] = {
                        background_analysis = {
                            dotnet_analyzer_diagnostics_scope = "openFiles",
                            dotnet_compiler_diagnostics_scope = "openFiles",
                        },
                    },
                    ["csharp|inlay_hints"] = {
                        csharp_enable_inlay_hints_for_implicit_object_creation = true,
                        csharp_enable_inlay_hints_for_implicit_variable_types = true,
                    },
                    ["csharp|code_lens"] = {
                        dotnet_enable_references_code_lens = true,
                    },
                },
            })

            vim.lsp.enable("roslyn")

            vim.api.nvim_create_autocmd({ "InsertLeave" }, {
                pattern = "*",
                callback = function()
                    local clients = vim.lsp.get_clients({ name = "roslyn" })
                    if not clients or #clients == 0 then
                        return
                    end

                    local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)
                    for _, buf in ipairs(buffers) do
                        vim.lsp.util._refresh("textDocument/diagnostic", { bufnr = buf })
                    end
                end,
            })

            vim.diagnostic.config({
                severity_sort = true,
                float = {
                    source = "if_many",
                },
                underline = {
                    severity = {
                        vim.diagnostic.severity.ERROR,
                        vim.diagnostic.severity.WARN,
                    },
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚 ",
                        [vim.diagnostic.severity.WARN] = "󰀪 ",
                        [vim.diagnostic.severity.INFO] = "󰋽 ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                    },
                },
                virtual_text = {
                    source = "if_many",
                    spacing = 2,
                    format = function(diagnostic)
                        local diagnostic_message = {
                            [vim.diagnostic.severity.ERROR] = diagnostic.message,
                            [vim.diagnostic.severity.WARN] = diagnostic.message,
                            [vim.diagnostic.severity.INFO] = diagnostic.message,
                            [vim.diagnostic.severity.HINT] = diagnostic.message,
                        }
                        return diagnostic_message[diagnostic.severity]
                    end,
                },
            })
        end,
    },
    {
        "seblyng/roslyn.nvim",
        enabled = true,
        ft = "cs",
        ---@module 'roslyn.config'
        ---@type RoslynNvimConfig
        opts = {
            lock_target = true,
        },
    },
}
