return {
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		version = "v2.*",
		dependencies = {
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").lazy_load({
						paths = { vim.fn.stdpath("config") .. "/snippets" },
					})
				end,
			},
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
			tree = { enabled = false },
		},
	},
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = {
			"mason.nvim",
			{ "williamboman/mason-lspconfig.nvim", config = function() end },
		},
		version = "*",
		opts = {
			keymap = { preset = "enter" },
			snippets = {
				preset = "luasnip",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			cmdline = {
				enabled = false,
			},
			-- experimental signature help support
			-- signature = { enabled = true }
		},
		-- allows extending the providers array elsewhere in your config
		-- without having to redefine it
		opts_extend = { "sources.default" },
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp", "b0o/schemastore.nvim" },
		opts = {
			servers = {
				lua_ls = {},
				gopls = {},
				ts_ls = {},
				pyright = {},
				jdtls = {},
				helm_ls = {},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			for server, config in pairs(opts.servers) do
				-- passing config.capabilities to blink.cmp merges with the capabilities in your
				-- `opts[server].capabilities, if you've defined it
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end

			lspconfig.yamlls.setup({
				capabilities = require("blink.cmp").get_lsp_capabilities(),
				settings = {
					yaml = {
						schemas = require("schemastore").yaml.schemas(),
						format = { enable = true },
					},
					redhat = {
						telemetry = {
							enabled = false,
						},
					},
				},
			})
		end,
	},
}
