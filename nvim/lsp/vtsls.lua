return {
	cmd = {
		"vtsls",
		"--stdio",
	},
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = {
		"bun.lockb",
		"bun.lock",
		"package.json",
		"tsconfig.json",
		"jsconfig.json",
		".git",
	},
	settings = {
		typescript = {
			inlayHints = {
				parameterNames = { enabled = "all" },
				variableTypes = { enabled = true },
			},
		},
		javascript = {
			inlayHints = {
				parameterNames = { enabled = "all" },
			},
		},
	},
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}

