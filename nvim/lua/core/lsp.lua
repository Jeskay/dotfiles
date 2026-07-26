vim.lsp.config("clangd", dofile(vim.fn.stdpath("config") .. "/lsp/clangd.lua"))

vim.lsp.enable({
  "gopls",
  "lua_ls",
  "vtsls",
  "pyls",
  "clangd",
  "ktlsp",
})
