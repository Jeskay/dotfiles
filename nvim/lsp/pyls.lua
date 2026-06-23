return {
  cmd = {
    "pyright-langserver",
    "--stdio"
  },
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      }
    }
  },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
