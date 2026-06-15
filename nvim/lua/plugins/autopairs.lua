return {
  "altermo/ultimate-autopair.nvim",
  event = { "InsertEnter", "CmdlineEnter" },
  branch = "v0.6",
  opts = {
    config = {
      disable_ft = { "TelescopePrompt" },
    },
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
      pattern = "TelescopePrompt",
      callback = function()
        vim.b.ultimate_autopair_disable = true
        pcall(vim.keymap.del, "i", "<BS>", { buffer = true })
      end,
    })

    require("ultimate-autopair").setup(opts)
  end,
}

