return {
	"greggh/claude-code.nvim",
	config = function()
		require("claude-code").setup({
			window = {
				split_ratio = 0.3,
				position = "vertical",
			},
		})
	end,
}
