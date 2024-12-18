return {
	{ "nvim-tree/nvim-web-devicons", config = true },

	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				sync_install = false,
				ignore_install = {},
				ensure_installed = {
					"vim",
					"lua",
					"bash",
					"ruby",
					"python",
					"php",
					"c",
					"rust",
					"go",
					"gomod",
					"gosum",
					"gitignore",
					"dockerfile",
					"cpp",
					"dart",
					"yaml",
					"json",
					"jsonc",
					"http",
					"json5",
					"terraform",
					"java",
					"scala",
					"kotlin",
					"typescript",
					"javascript",
					"html",
					"toml",
					"markdown",
					"markdown_inline",
					"css",
					"scss",
					"sql",
					"proto",
					"make",
					"cmake",
					"latex",
					"kdl",
				},
				autopairs = {
					enable = true,
				},
				indent = {
					enable = true,
					disable = { "yaml" },
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})

			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.gotmpl = {
				install_info = {
					url = "https://github.com/ngalaiko/tree-sitter-go-template",
					files = { "src/parser.c" },
				},
				filetype = "gotmpl",
				used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
			}
		end,
	},

	{
		"echasnovski/mini.nvim",
		branch = "main",
		config = function()
			require("mini.align").setup()
		end,
	},
	{ "numToStr/Comment.nvim", config = true },
	{ "lewis6991/gitsigns.nvim", config = true },
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				git = { enable = false },
				update_focused_file = { enable = true },
				view = {
					width = { min = 40, max = 60 },
					float = {
						enable = false,
						quit_on_focus_loss = true,
						open_win_config = {
							relative = "editor",
							border = "rounded",
						},
					},
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = false,
					custom = {
						"^\\.git$",
						"node_modules",
						"^\\.cache",
						"__pycache__",
						"\\.direnv",
						"\\.ipynb_checkpoints",
						"vendor",
					},
				},
				actions = {
					open_file = {
						resize_window = false,
						window_picker = {
							enable = false,
						},
					},
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					theme = "gruvbox",
					always_show_bufferline = true,
				},
				extensions = { "quickfix", "nvim-tree", "fzf" },
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"filename",
							file_status = true,
							path = 1,
						},
					},
					lualine_x = { "encoding", "filetype" },
					lualine_y = { "progress", "diff" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "tabs",
					numbers = "ordinal",
					diagnostics = "nvim_lsp",
					show_buffer_close_icons = false,
					show_close_icon = false,
				},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
			}

			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#dedede" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#cfcccc" })
			end)

			require("ibl").setup({
				indent = {
					char = { "|", "¦", "┆", "┊" },
					smart_indent_cap = false,
					highlight = highlight,
				},
				scope = {
					enabled = false,
					highlight = highlight,
				},
				whitespace = { highlight = { "Whitespace", "NonText" } },
			})
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{ "kylechui/nvim-surround", config = true },
	{ "gpanders/editorconfig.nvim" },
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				filetypes_denylist = {
					"dirbuf",
					"dirvish",
					"fugitive",
					"NvimTree",
				},
			})

			-- https://ansidev.xyz/posts/2023-04-25-how-to-change-the-highlight-style-using-vim-illuminate
			-- change the highlight style
			vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
			vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
			vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

			--- auto update the highlight style on colorscheme change
			vim.api.nvim_create_autocmd({ "ColorScheme" }, {
				pattern = { "*" },
				callback = function(ev)
					vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
					vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
					vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
				end,
			})
		end,
	},

	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				go = { "golangcilint" },
			}
		end,
	},
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
	},

	{ "mrcjkb/rustaceanvim", version = "^4", ft = "rust" },
	-- dotnet
	{
		"Hoffs/omnisharp-extended-lsp.nvim",
	},
}
