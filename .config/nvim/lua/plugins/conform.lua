return {
    "stevearc/conform.nvim",

    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_format" },
                c = { "clang_format" },
                cpp = { "clang_format" },
            },
        })

        vim.keymap.set("n", "<F3>", function()
            conform.format({ async = true, lsp_format = "fallback" })
        end, { desc = "Format file" })
    end,
}
