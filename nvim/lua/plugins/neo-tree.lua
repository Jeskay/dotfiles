return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      "nvim-tree/nvim-web-devicons",
      opts = {
        override = {
          sh = {
            icon = "",
            color = "#f15a24",
            name = "Sh",
          },
        },
      },
    },
  },
  lazy = false,
  config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        width = 30,
        fixed_width = true,
        mappings = {
          ["u"] = "navigate_up",
          ["c"] = {
            "copy",
            config = {
              show_path = "relative"
            }
          }
        }
      },
    })
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle left<CR>", {})
  end,
}
