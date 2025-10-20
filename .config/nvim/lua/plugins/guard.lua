return {
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
		--- ft("typescript,javascript,typescriptreact"):fmt({
		--- 	cmd = "prettier-eslint",
		--- 	args = { "--stdin", "--stdin-filepath" },
		--- 	fname = true,
		--- 	stdin = true,
		--- })

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
