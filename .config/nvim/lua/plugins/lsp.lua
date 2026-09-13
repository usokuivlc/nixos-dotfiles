return {
    "neovim/nvim-lspconfig",

    config = function()
        -- Configuración de Lua para Neovim
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },

                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                },
            },
        })

        -- Activar servidores
        vim.lsp.enable({
            "clangd",
            "pyright",
            "lua_ls",
        })

        -- Autocompletado nativo de Neovim
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)

                if client
                    and client:supports_method("textDocument/completion")
                then
                    vim.lsp.completion.enable(
                        true,
                        client.id,
                        args.buf,
                        {
                            autotrigger = true,
                        }
                    )
                end
            end,
        })

        -- LSP keybinds
        vim.keymap.set("n", "gd", vim.lsp.buf.definition)
        vim.keymap.set("n", "K", vim.lsp.buf.hover)

        vim.keymap.set(
            "n",
            "<leader>vws",
            vim.lsp.buf.workspace_symbol
        )

        vim.keymap.set(
            "n",
            "<leader>vd",
            vim.diagnostic.open_float
        )

        vim.keymap.set(
            "n",
            "<leader>vca",
            vim.lsp.buf.code_action
        )

        vim.keymap.set(
            "n",
            "<leader>vrr",
            vim.lsp.buf.references
        )

        vim.keymap.set(
            "n",
            "<leader>vrn",
            vim.lsp.buf.rename
        )
    end,
}
