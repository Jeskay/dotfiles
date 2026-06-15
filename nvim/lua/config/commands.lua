-- Show diagnostic window on hover
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = true,
      close_events = { "BufLeave", "InsertEnter", "CursorMoved", "FocusLost" },
      border = "double",
      source = "always",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})
-- Open preconfigured command terminal window
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})
-- Find references in telescope
vim.api.nvim_create_autocmd({"LspAttach"}, {
  callback = function()
    vim.keymap.set("n", "gr", function()
      require("telescope.builtin").lsp_references()
    end, {buffer = 0, noremap = true, silent = true})
  end
})
-- Toggle terminal window
vim.keymap.set("n", "<leader>st", function()
  vim.cmd("botright 10split")
  vim.cmd.term()
  vim.cmd("startinsert")
end)
-- Toggle cmd line while recording macro
vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function() vim.opt.cmdheight = 1 end,
})
vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function() vim.opt.cmdheight = 0 end,
})
