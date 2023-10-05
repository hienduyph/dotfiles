local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	checker = {
		-- automatically check for plugin updates
		enabled = true,
		notify = false,
	},
}

local plugins = {
	-- core libs
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
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
					disable = { "yaml", "python" },
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},

	{
		"echasnovski/mini.nvim",
		branch = "main",
		config = function()
			require("mini.base16").setup({
				palette = {
					base00 = "#ffffff",
					base01 = "#f6f8eb",
					base02 = "#dbe1ac",
					base03 = "#73765a",
					base04 = "#324490",
					base05 = "#002a83",
					base06 = "#0000e4",
					base07 = "#080500",
					base08 = "#5e2200",
					base09 = "#a86400",
					base0A = "#008818",
					base0B = "#004500",
					base0C = "#b34aad",
					base0D = "#004b76",
					base0E = "#7d0077",
					base0F = "#0086ae",
				},
				use_cterm = {
					base00 = 254,
					base01 = 250,
					base02 = 246,
					base03 = 243,
					base04 = 60,
					base05 = 18,
					base06 = 4,
					base07 = 232,
					base08 = 52,
					base09 = 130,
					base0A = 28,
					base0B = 22,
					base0C = 133,
					base0D = 24,
					base0E = 90,
					base0F = 31,
				},
			})
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
				view = {
					width = 40,
				},
				update_focused_file = {
					enable = true,
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
					enabled = true,
					highlight = highlight,
				},
				whitespace = { highlight = { "Whitespace", "NonText" } },
			})
		end,
	},

	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
				ts_config = {
					lua = { "string" }, -- it will not add a pair on that treesitter node
					javascript = { "template_string" },
					java = false, -- don"t check treesitter on java
				},
			})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",

			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			"SmiteshP/nvim-navic",
		},
	},
	{
		"mfussenegger/nvim-dap",
	},

	-- specific language
	{
		"scalameta/nvim-metals",
	},

	{ "b0o/schemastore.nvim" },

	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
	},

	{ "simrat39/rust-tools.nvim", config = true },
	{ "kylechui/nvim-surround", config = true },
	"gpanders/editorconfig.nvim",
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {},
	},
	{
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	},
	{
		"rest-nvim/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("rest-nvim").setup({
				-- Open request results in a horizontal split
				result_split_horizontal = false,
				-- Keep the http file buffer above|left when split horizontal|vertical
				result_split_in_place = "vertical",
				-- Skip SSL verification, useful for unknown certificates
				skip_ssl_verification = false,
				-- Encode URL before making request
				encode_url = true,
				-- Highlight request on run
				highlight = {
					enabled = true,
					timeout = 150,
				},
				result = {
					-- toggle showing URL, HTTP info, headers at top the of result window
					show_url = true,
					-- show the generated curl command in case you want to launch
					-- the same request via the terminal (can be verbose)
					show_curl_command = true,
					show_http_info = true,
					show_headers = true,
					-- executables or functions for formatting response body [optional]
					-- set them to false if you want to disable them
					formatters = {
						json = "jq",
						html = function(body)
							return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
						end,
					},
				},
				-- Jump to request line on run
				jump_to_request = false,
				custom_dynamic_variables = {},
				yank_dry_run = true,
			})

			vim.keymap.set("n", "<leader>c", function()
				require("rest-nvim").run()
			end, { noremap = true, silent = true })

			vim.api.nvim_create_user_command("Curl", function()
				require("rest-nvim").run(true)
			end, { nargs = 0 })
		end,
	},
}

local guard = {
	"nvimdev/guard.nvim",
	config = function()
		local ft = require("guard.filetype")
		ft("python"):fmt("black")
		ft("lua"):fmt("stylua")
		ft("proto,c,cpp"):fmt("clang-format")
		ft("typescript,javascript,typescriptreact,markdown,html,css,yaml"):fmt("prettier")
		ft("rust"):fmt("rustfmt")
		ft("sh"):fmt({
			cmd = "shfmt",
			stdin = true,
		})
		ft("json"):fmt({
			cmd = "jq",
			stdin = true,
		})
		require("guard").setup({
			fmt_on_save = false, -- only enable for some filetype
			lsp_as_default_formatter = true,
		})
	end,
	dependencies = { "nvimdev/guard-collection" },
}

local conform = {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			format_after_save = {
				lsp_fallback = true,
			},

			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				-- Use a sub-list to run only the first available formatter
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				yaml = { { "prettierd", "prettier" } },
				json = { "jq" },
				proto = { "clang_format" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
			},
		})
	end,
}

local fzf = {
	{
		"ibhagwan/fzf-lua",
		config = function()
			vim.keymap.set("n", "<C-f>", function()
				require("fzf-lua").files()
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "<C-g>", function()
				require("fzf-lua").live_grep()
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "<C-i>", function()
				require("fzf-lua").buffers()
			end, { noremap = true, silent = true })
		end,
		requires = { "nvim-tree/nvim-web-devicons" },
	},
}

local telescope = {
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local tele = require("telescope")
			tele.setup({
				defaults = {
					file_ignore_patterns = { "^.git/" },
					selection_strategy = "reset",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
				},
			})
			tele.load_extension("fzf")

			vim.keymap.set("n", "<C-f>", function()
				require("telescope.builtin").find_files({ hidden = true })
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "<C-g>", function()
				require("telescope.builtin").live_grep({ hidden = true })
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "<C-i>", function()
				require("telescope.builtin").buffers()
			end, { noremap = true, silent = true })
		end,
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
		},
	},
}

table.insert(plugins, telescope)
table.insert(plugins, conform)
require("lazy").setup(plugins, opts)
