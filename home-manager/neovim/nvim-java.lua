local home = os.getenv("HOME")
local jdtls = require("jdtls")
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
local root_dir = require("jdtls.setup").find_root(root_markers)

-- If root_dir is nil, use current working directory
if root_dir == nil then
	root_dir = vim.fn.getcwd()
end

local workspace_folder = home .. "/.cache/jdtls/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Setting up root_dir
local lspconfig = require("lspconfig")
local function get_root_dir()
	return lspconfig.util.root_pattern(unpack(root_markers))(vim.fn.expand("%:p:h"))
end

local jdtls_config_dir = home .. "/.config/jdtls_config"
os.execute("mkdir -p " .. jdtls_config_dir)

-- Copy from nix store to config dir
os.execute("cp -r " .. jdts_install .. "/share/java/jdtls/config_linux/* " .. jdtls_config_dir)

-- Debuging
-- local bundles = {}
-- local debug_bundles = vim.split(
-- 	vim.fn.glob(
-- 		"${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/*.jar"
-- 	),
-- 	"\n"
-- )
-- local test_bundles = vim.split(
-- 	vim.fn.glob(
-- 		"${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar"
-- 	),
-- 	"\n"
-- )
-- vim.list_extend(bundles, debug_bundles)
-- vim.list_extend(bundles, test_bundles) TODO: Need to look into

java_on_attach = function(client, bufnr)
	attach_keymaps(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<leader>jo", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
	vim.keymap.set("n", "<leader>jrv", "<Cmd>lua require'jdtls'.extract_variable()<CR>", opts)
	vim.keymap.set("x", "<leader>jrv", "<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>", opts)
	vim.keymap.set("n", "<leader>jrc", "<Cmd>lua require'jdtls'.extract_constant()<CR>", opts)
	vim.keymap.set("x", "<leader>jrc", "<Esc><Cmd>lua require'jdtls'.extract_constant(true)<CR>", opts)
	vim.keymap.set("x", "<leader>jrm", "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>", opts)

	-- Set autocommands conditional on server_capabilities
	vim.lsp.codelens.refresh()
end

local config = {
	flags = {
		allow_incremental_sync = true,
	},
	capabilities = capabilities,
	on_attach = java_on_attach,
}

config.settings = {
	java = {
		referencesCodeLens = { enabled = true },
		signatureHelp = { enabled = true },
		implementationsCodeLens = { enabled = true },
		contentProvider = { preferred = "fernflower" },
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
		},
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		configuration = {
			runtimes = {
				{
					name = "JavaSE-17",
					path = jdk_17 .. "/lib/openjdk/",
				},
				{
					name = "JavaSE-21",
					path = jdk_21 .. "/lib/openjdk/",
				},
			},
		},
	},
}
config.cmd = {
	jdts_install .. "/bin/jdtls",
	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Dosgi.sharedConfiguration.area=" .. jdts_install .. "/share/config",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=ALL",
	"-Xms1g",
	"--add-modules=ALL-SYSTEM",
	"--add-opens",
	"java.base/java.util=ALL-UNNAMED",
	"--add-opens",
	"java.base/java.lang=ALL-UNNAMED",
	"-jar",
	"-configuration",
	jdtls_config_dir,
	"-data",
	workspace_folder,
}
config.root_dir = get_root_dir()
config.on_init = function(client, _)
	client.notify("workspace/didChangeConfiguration", { settings = config.settings })
end

local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
config.init_options = {
	bundles = bundles,
	extendedClientCapabilities = extendedClientCapabilities,
}
config.filetypes = { "java" }
local nvim_jdtls_group = vim.api.nvim_create_augroup("nvim-jdtls", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "java" },
	callback = function()
		jdtls.start_or_attach(config)
		-- jdtls.setup_dap({ hotcodereplace = "auto" })
		-- jdtls.dap.setup_dap_main_class_configs() TODO: return a nil
	end,
	group = nvim_jdtls_group,
})
