return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- Keep tracking main
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site"
    })

    local parsers = { "lua", "go", "javascript", "typescript", "tsx", "json", "markdown", "markdown_inline" }
    ts.install(parsers)
    vim.api.nvim_set_hl(0, "foo.bar", { link = "Identifier" })
  end,
}

