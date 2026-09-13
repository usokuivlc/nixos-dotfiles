return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
        local ts = require("nvim-treesitter")

        ts.install({
            "lua",
            "python",
            "c",
            "cpp",
            "bash",
            "json",
            "markdown",
            "markdown_inline",
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "lua",
                "python",
                "c",
                "cpp",
                "bash",
                "json",
                "markdown",
            },

            callback = function()
                vim.treesitter.start()

                vim.bo.indentexpr =
                    "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
