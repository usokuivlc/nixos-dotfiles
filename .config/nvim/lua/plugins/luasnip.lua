return {
    "L3MON4D3/LuaSnip",

    config = function()
        local ls = require("luasnip")

        ls.config.setup({
            enable_autosnippets = true,
            update_events = "TextChanged,TextChangedI",
            cut_selection_keys = "<Tab>",
        })

        require("luasnip.loaders.from_lua").lazy_load({
            paths = vim.fn.stdpath("config") .. "/luasnip",
        })

        -- Expandir snippet / saltar al siguiente campo
        vim.keymap.set({ "i", "s" }, "<Tab>", function()
            if ls.expand_or_jumpable() then
                return "<Plug>luasnip-expand-or-jump"
            end
            return "<Tab>"
        end, { expr = true, silent = true })

        -- Volver al campo anterior
        vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
            if ls.jumpable(-1) then
                return "<Plug>luasnip-jump-prev"
            end
            return "<S-Tab>"
        end, { expr = true, silent = true })
    end,
}
