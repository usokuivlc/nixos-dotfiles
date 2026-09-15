return {
    "lervag/vimtex",
    lazy = false,

    init = function()
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_quickfix_mode = 0

        if vim.fn.has("macunix") == 1 then
            vim.g.vimtex_view_method = "skim"
            vim.g.vimtex_view_skim_sync = 1
            vim.g.vimtex_view_skim_activate = 1
        else
            vim.g.vimtex_view_method = "zathura"
        end
    end,
}
