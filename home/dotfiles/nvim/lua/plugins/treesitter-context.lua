-- Fabian. Show context up top in which function you are etc
return {
	"nvim-treesitter/nvim-treesitter-context",
	opts = {
		enable = true,
		multiwindow = false,
		max_lines = 3, -- How many lines of context to show
		trim_scope = "outer",
		mode = "cursor", -- Use "topline" to show based on viewport instead
		separator = nil, -- You can set a line separator like "─"
		line_numbers = true,
	},
}
