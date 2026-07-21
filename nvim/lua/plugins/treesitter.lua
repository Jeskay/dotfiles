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
    -- Query files can remain after a parser binary disappears, so check the
    -- installed parser binaries specifically instead of the combined list.
    local installed = {}
    for _, parser in ipairs(ts.get_installed("parsers")) do
      installed[parser] = true
    end

    local missing = {}
    for _, parser in ipairs(parsers) do
      if not installed[parser] then
        missing[#missing + 1] = parser
      end
    end

    -- Installation is asynchronous by default. Wait here so a FileType event
    -- cannot try to start Tree-sitter before a missing parser is installed.
    if #missing > 0 then
      ts.install(missing, { force = true }):wait(300000)
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c", "cpp" },
      callback = function(args)
        local ok, err = pcall(vim.treesitter.start, args.buf)
        if not ok then
          vim.notify("Tree-sitter could not start: " .. err, vim.log.levels.WARN)
        end
      end,
    })
  end,
}
