return {
	cmd = {
		"lua-language-server",
	},
	filetypes = {
		"lua",
	},
	root_markers = {
		".git",
		".luacheckrc",
		".luarc.json",
		".luarc.jsonc",
		".stylua.toml",
		"selene.toml",
		"selene.yml",
		"stylua.toml",
	},
	 settings = {
	     Lua = {
	         diagnostics = {
              globals = { "vim" },
	         },
            diagnosticsOnOpen = true,
            diagnosticsOnSave = true,
	     },
	 },

	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}
