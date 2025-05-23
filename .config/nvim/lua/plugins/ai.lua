vim.api.nvim_set_hl(0, "MyAvanteCurrentGroup", {
	fg = "#FF0000",
	bg = "#00FF00",
	bold = true,
})

return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		opts = {
			provider = "gemini-2.5",
			gemini = {
				model = os.getenv("GEMINI_MODEL"), -- "gemini-2.5-flash-preview-04-17",
				timeout = 30000,
				temperature = 0,
				max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
			},
			vendors = {
				["gemini-2.5"] = {
					__inherited_from = "openai",
					endpoint = "https://openrouter.ai/api/v1",
					api_key_name = "OPENROUTER_API_KEY",
					model = "google/gemini-2.5-flash-preview",
					timeout = 30000, -- Timeout in milliseconds
					temperature = 0,
					max_tokens = 20000,
				},
			},
			web_search_engine = {
				provider = "searxng", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
			},
			highlights = {
				diff = {
					current = "MyAvanteCurrentGroup",
				},
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"stevearc/dressing.nvim",
			"MunifTanjim/nui.nvim",
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
		},
	},
}
