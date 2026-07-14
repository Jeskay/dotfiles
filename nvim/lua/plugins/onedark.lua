return {
  "olimorris/onedarkpro.nvim",
  priority = 1000,
  config = function()
    require("onedarkpro").setup({
      highlights = {
        ["@lsp.type.variable.cpp"] = { fg = "${red}" },
        ["@lsp.type.parameter.cpp"] = { fg = "${orange}" },
        ["@lsp.type.property.cpp"] = { fg = "${cyan}" },
        ["@lsp.type.function.cpp"] = { fg = "${blue}" },
        ["@lsp.type.method.cpp"] = { fg = "${green}" },
        ["@lsp.type.class.cpp"] = { fg = "${yellow}" },
        ["@lsp.type.struct.cpp"] = { fg = "${yellow}" },
        ["@lsp.type.type.cpp"] = { fg = "${yellow}" },
        ["@lsp.type.enum.cpp"] = { fg = "${purple}" },
        ["@lsp.type.enumMember.cpp"] = { fg = "${orange}" },
        ["@lsp.type.typeParameter.cpp"] = { fg = "${purple}" },
        ["@lsp.type.namespace.cpp"] = { fg = "${cyan}" },
        ["@lsp.type.macro.cpp"] = { fg = "${orange}" },
        ["@lsp.typemod.variable.readonly.cpp"] = { fg = "${yellow}" },
      },
      options = {
        transparency = true,
      },
    })
    vim.cmd("colorscheme onedark")
  end
}
