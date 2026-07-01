vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.updatetime = 1000

-- Sync wayland clipboard
vim.opt.clipboard = "unnamedplus"

-- Clipboard sync over ssh
local function is_ssh()
  return vim.env.SSH_CLIENT ~= nil or vim.env.SSH_TTY ~= nil
end

if is_ssh() then
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste("+"),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    }
  }
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
