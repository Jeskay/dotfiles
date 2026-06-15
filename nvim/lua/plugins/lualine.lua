return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
      globalstatus = true,
			theme = "onedark",
		},
		sections = {
			lualine_c = {
				{
					"filename",
					path = 1,
					shorting_target = 40,
				},
			},
      lualine_x = {
        {
          'filetype',
        }
      }
		},
	},
}
