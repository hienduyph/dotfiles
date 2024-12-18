return {
	-- specific language
	{
		"scalameta/nvim-metals",
		ft = "scala",
	},
	-- go
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{ "mrcjkb/rustaceanvim", version = "^4", ft = "rust" },
	-- dotnet
	{
		"Hoffs/omnisharp-extended-lsp.nvim",
	},
}
