vim.lsp.config("clangd", dofile(vim.fn.stdpath("config") .. "/lsp/clangd.lua"))
vim.lsp.config("vtsls", dofile(vim.fn.stdpath("config") .. "/lsp/vtsls.lua"))

vim.lsp.enable({
  "gopls",
  "lua_ls",
  "vtsls",
  "vue_ls",
  "pyls",
  "clangd",
  "ktlsp",
})
