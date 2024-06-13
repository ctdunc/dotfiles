return {
	"tpope/vim-sleuth",
	"tpope/vim-fugitive",
	"tpope/vim-dispatch",
	"radenling/vim-dispatch-neovim",
	"tshirtman/vim-cython",
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true,
		opts = {
			underline = true,
			bold = true,
			italic = {
				strings = false,
				emphasis = false,
				comments = false,
				operators = false,
				folds = true,
			},
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "hard", -- can be "hard", "soft" or empty string
		},
	},
}
