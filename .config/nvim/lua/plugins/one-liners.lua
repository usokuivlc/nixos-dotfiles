return {
    { "tpope/vim-fugitive" },

    {
	"NvChad/nvim-colorizer.lua",
	config = function()
	    require("colorizer").setup()
	end,
    },
}
