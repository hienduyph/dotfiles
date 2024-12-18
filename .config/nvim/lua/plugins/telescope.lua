return {
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
