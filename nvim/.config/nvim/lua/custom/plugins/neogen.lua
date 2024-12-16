return {
	"danymat/neogen",
	-- Uncomment next line if you want to follow only stable versions
	version = "*",
	opts = {
		input_after_comment = false,
		languages = {
			python = {
				template = {
					annotation_convention = "numpydoc",
				},
			},
		},
	},
}
