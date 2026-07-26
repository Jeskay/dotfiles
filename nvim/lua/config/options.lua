vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.updatetime = 1000
-- Clipboard sync over ssh
local function is_ssh()
  return vim.env.SSH_CLIENT ~= nil or vim.env.SSH_TTY ~= nil
end

if is_ssh() then
  vim.opt.clipboard = ""
  vim.g.clipboard = "osc52"
else
  vim.opt.clipboard = "unnamedplus"
end

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
