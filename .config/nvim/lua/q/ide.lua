local dap = require("dap")
local dapui = require("dapui")
require("nvim-dap-virtual-text").setup()

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dap.configurations.scala = {
	{
		type = "scala",
		request = "launch",
		name = "RunOrTest",
		metals = {
			runType = "runOrTestFile",
			--args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
		},
	},
	{
		type = "scala",
		request = "launch",
		name = "RunMain",
		metals = {
			runType = "run",
			--args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
		},
	},
	{
		type = "scala",
		request = "launch",
		name = "Test Target",
		metals = {
			runType = "testTarget",
		},
	},
}
-- scala
-- https://github.com/scalameta/nvim-metals/discussions/39
local metals_config = require("metals").bare_config()
metals_config.settings = {
	showImplicitArguments = true,
	useGlobalExecutable = true,
	excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
metals_config.on_attach = function(client, bufnr)
	vim.lsp.inlay_hint(bufnr, true)
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "scala", "sbt" },
	callback = function()
		require("metals").initialize_or_attach(metals_config)
		require("metals").setup_dap()
	end,
	group = nvim_metals_group,
})

require("dap-go").setup({
	delve = {
		-- the path to the executable dlv which will be used for debugging.
		-- by default, this is the "dlv" executable on your PATH.
		path = "dlv",
		-- time to wait for delve to initialize the debug session.
		-- default to 20 seconds
		initialize_timeout_sec = 20,
		-- a string that defines the port to start delve debugger.
		-- default to string "${port}" which instructs nvim-dap
		-- to start the process in a random available port
		port = "${port}",
		-- additional args to pass to dlv
		args = {},
		-- the build flags that are passed to delve.
		-- defaults to empty string, but can be used to provide flags
		-- such as "-tags=unit" to make sure the test suite is
		-- compiled during debugging, for example.
		-- passing build flags using args is ineffective, as those are
		-- ignored by delve in dap mode.
		build_flags = "",
	},
})
require("dap-python").setup()

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		local jdtls_setup = require("jdtls.setup")
		local home = os.getenv("HOME")
		local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
		local root_dir = jdtls_setup.find_root(root_markers)

		local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
		local workspace_dir = home .. "/.cache/jdtls/workspace" .. project_name
		local jdtls_bin = vim.fn.stdpath("data") .. "/mason/bin/jdtls"

		local config = {
			-- The command that starts the language server
			-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
			--
			cmd = {
				jdtls_bin,
				"-data",
				workspace_dir,
			},
			root_dir = root_dir,
			-- Here you can configure eclipse.jdt.ls specific settings
			-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
			-- for a list of options
			settings = {
				java = {
					references = {
						includeDecompiledSources = true,
					},
					format = {
						enabled = true,
						settings = {
							url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
							profile = "GoogleStyle",
						},
					},
					eclipse = {
						downloadSources = true,
					},
					maven = {
						downloadSources = true,
					},
					gradle = {
						enabled = true,
					},
					signatureHelp = { enabled = true },
					contentProvider = { preferred = "fernflower" },
					-- eclipse = {
					-- 	downloadSources = true,
					-- },
					-- implementationsCodeLens = {
					-- 	enabled = true,
					-- },
					completion = {
						favoriteStaticMembers = {
							"org.hamcrest.MatcherAssert.assertThat",
							"org.hamcrest.Matchers.*",
							"org.hamcrest.CoreMatchers.*",
							"org.junit.jupiter.api.Assertions.*",
							"java.util.Objects.requireNonNull",
							"java.util.Objects.requireNonNullElse",
							"org.mockito.Mockito.*",
						},
						filteredTypes = {
							"com.sun.*",
							"io.micrometer.shaded.*",
							"java.awt.*",
							"jdk.*",
							"sun.*",
						},
						importOrder = {
							"java",
							"javax",
							"com",
							"org",
						},
					},
					sources = {
						organizeImports = {
							starThreshold = 9999,
							staticStarThreshold = 9999,
						},
					},
					codeGeneration = {
						toString = {
							template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
							-- flags = {
							-- 	allow_incremental_sync = true,
							-- },
						},
						useBlocks = true,
					},
				},
			},
			handlers = {
				-- ["language/status"] = function(_, result)
				--		print(result)
				--end,
				-- ["$/progress"] = function(_, result, ctx)
				-- disable progress updates.
				-- end,
			},
		}
		require("jdtls").start_or_attach(config)
	end,
})
