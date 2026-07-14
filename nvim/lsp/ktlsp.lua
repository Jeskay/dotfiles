return {
  cmd = {
    "kotlin-language-server"
  },
  filetypes = { "kotlin", "kotlin.script" },
  root_markers = {
    "settings.gradle",
    "settings.gradle.kts",
    "build.gradle",
    "guild.gradle.kts",
    ".git"
  },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
