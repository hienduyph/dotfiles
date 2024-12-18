return {
	"adalessa/laravel.nvim",
	cmd = { "Laravel" },
	ft = "php",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	event = { "VeryLazy" },
	opts = {
		features = {
			null_ls = {
				enable = false,
			},
			route_info = {
				enable = true, --- to enable the laravel.nvim virtual text
				position = "right", --- where to show the info (available options 'right', 'top')
				middlewares = true, --- wheather to show the middlewares section in the info
				method = true, --- wheather to show the method section in the info
				uri = true, --- wheather to show the uri section in the info
			},
		},
	},
	config = true,
}
