local M = {}

function M.in_math()
    if vim.fn.exists("*vimtex#syntax#in_mathzone") == 1 then
        return vim.fn["vimtex#syntax#in_mathzone"]() == 1
    end

    return false
end

function M.in_text()
    return not M.in_math()
end

return M
