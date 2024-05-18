vim.o.completeopt = "menuone,noselect"

require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = true,
	ensure_installed = { "jdtls" },
})

local navic = require("nvim-navic")
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#auto-import
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{
			name = "buffer",
			option = {
				keyword_length = 1,
				-- get completion in all buffer
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "path" },
		{ name = "nvim_lua" },
	},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local M = {}
local nvim_lsp = require("lspconfig")

local flags = {
	debounce_text_changes = 150,
}
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local opts = { noremap = true, silent = true }

	vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

	-- Set some keybinds conditional on server capabilities
	if client.server_capabilities.document_formatting then
		buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.server_capabilities.document_range_formatting then
		buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end

	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

function M.setup_ls(lsp)
	nvim_lsp[lsp].setup({
		capabilities = capabilities,
		on_attach = on_attach,
		flags = flags,
	})
end

function M.angularls()
	M.setup_ls("angularls")
end

function M.node()
	M.setup_ls("tsserver")
	M.setup_ls("eslint")
end

function M.deno()
	M.setup_ls("denols")
end

local servers = { "html", "cssls", "bashls" }
for _, lsp in ipairs(servers) do
	M.setup_ls(lsp)
end

M.node()

-- Rust setups
nvim_lsp.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	flags = flags,
	settings = {
		["rust-analyzer"] = {
			cargo = {
				loadOutDirsFromCheck = true,
				allFeatures = true,
				runBuildScripts = true,
			},
			procMacro = {
				enable = true,
			},
			checkOnSave = {
				command = "clippy",
			},
			diagnostics = {
				disabled = { "missing-unsafe" },
			},
		},
	},
})

nvim_lsp.jsonls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	flags = flags,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})
nvim_lsp.yamlls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	flags = flags,
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

-- Pyright
local function get_python_path(workspace)
	-- Use activated virtualenv.
	if vim.env.VIRTUAL_ENV then
		return nvim_lsp.util.path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end
	return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

nvim_lsp.pyright.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
	end,
	root_dir = nvim_lsp.util.root_pattern(unpack({ "pyproject.toml" })),
	flags = flags,
	before_init = function(_, config)
		config.settings.python.pythonPath = get_python_path(config.root_dir)
	end,
	settings = {
		python = {
			analysis = {
				executionEnvironments = { { root = "./" } },
				autoImportCompletions = true,
			},
		},
	},
})

-- Golang setup
nvim_lsp.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	flags = flags,
	settings = {
		gopls = {
			analyses = {
				unusedparams = false,
			},
			buildFlags = { "-tags=integration,wireinject,unit" },
			staticcheck = false,
		},
	},
})

nvim_lsp.clangd.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	flags = flags,
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
})

require("java").setup()
require("lspconfig").jdtls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	flags = flags,
})

-- lua with nvim
require("lspconfig").lua_ls.setup({
	flags = flags,
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false, -- disable 3rd check
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
			format = {
				enable = true,
				defaultConfig = {
					indent_style = "space",
					indent_size = "2",
					max_line_length = "unset",
				},
			},
		},
	},
})

return M
