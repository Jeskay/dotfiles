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

    local parsers = {
      "c",
      "cpp",
      "go",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "tsx",
      "typescript",
    }
    ts.install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c", "cpp" },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
