-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
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
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"b0o/schemastore.nvim",
			{
				"williamboman/mason.nvim",
				opts = {
					registries = {
						"github:nvim-java/mason-registry",
						"github:mason-org/mason-registry",
					},
				},
			},
			"williamboman/mason-lspconfig.nvim",
		},
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

local guard = {
	"nvimdev/guard.nvim",
	config = function()
		local ft = require("guard.filetype")
		ft("python"):fmt("ruff"):lint("ruff")
		ft("lua"):fmt("stylua")
		ft("proto,c,cpp"):fmt("clang-format")
		ft("markdown,html,css"):fmt("prettier")
		ft("yaml"):fmt({
			cmd = "yq",
			args = { "--input-format", "yaml", "--output-format", "yaml", "--indent", "2" },
			stdin = true,
			fname = true,
		})
		ft("xml"):fmt({
			cmd = "yq",
			args = { "--input-format", "xml", "--output-format", "xml", "--indent", "2" },
			stdin = true,
			fname = true,
		})
		-- ft("go"):lint("golangci_lint")
		ft("typescript,javascript,typescriptreact"):fmt({
			cmd = "prettier-eslint",
			args = { "--stdin", "--stdin-filepath" },
			fname = true,
			stdin = true,
		})

		ft("rust"):fmt("rustfmt")
		ft("sh"):fmt({
			cmd = "shfmt",
			stdin = true,
		})
		ft("json"):fmt({
			cmd = "jq",
			stdin = true,
		})
		ft("cs"):fmt("lsp")
		ft("php"):fmt("lsp")

		vim.g.guard_config = {
			fmt_on_save = false, -- only enable for some filetype
			lsp_as_default_formatter = true,
		}
	end,
	dependencies = { "nvimdev/guard-collection" },
}

local fzf = {
	{
		"ibhagwan/fzf-lua",
		config = function()
			vim.keymap.set("n", "<C-p>", function()
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
					file_ignore_patterns = { "^.git/", "^vendor/" },
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
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
				},
			})
			tele.load_extension("fzf")

			vim.keymap.set("n", "<C-f>", function()
				require("telescope.builtin").find_files({ hidden = true })
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "<C-p>", function()
				require("telescope.builtin").find_files({ hidden = true })
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "<C-g>", function()
				require("telescope.builtin").live_grep({ hidden = true })
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "<C-i>", function()
				require("telescope.builtin").buffers()
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "<C-i>", function()
				require("telescope.builtin").buffers()
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "<C-k>", function()
				require("telescope.builtin").commands()
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "<C-h>", function()
				require("telescope.builtin").command_history()
			end, { noremap = true, silent = true })
		end,
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
}
local php = {
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

table.insert(plugins, telescope)
table.insert(plugins, guard)
require("lazy").setup(plugins, opts)

vim.cmd([[colorscheme Mini16]])
