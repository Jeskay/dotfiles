vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.updatetime = 1000

-- Removes neovim cmd line
vim.opt.ruler = false
vim.opt.showcmd = false
vim.opt.cmdheight = 0

vim.diagnostic.config({
  float = {
    border = 'double',
    source = 'always',
    focusable = false
  }
})

--Filetype detection rules
vim.filetype.add({
  filename = {
    [".env"] = "sh",
  },
  pattern = {
    ["%.env.*"] = "sh",
  }
})
