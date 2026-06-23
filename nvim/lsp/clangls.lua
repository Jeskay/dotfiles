return {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iqwyu",
    "--completion-style=detailed",
    "--fallback-style=llvm"
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = lspconfig.util.root_pattern(
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "complete_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git"
  ),
  capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
    offsetEncoding = { "utf-16" },
  })
}
