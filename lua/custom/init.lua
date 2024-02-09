local opt = vim.opt

opt.scrolloff = 8
opt.relativenumber = true

vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/custom/lua_snippets"
vim.g.vscode_snippets_path = "~/.config/nvim/lua/custom/vscode_snippets"

vim.opt.clipboard = ""


vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.envrc",
  command = "set filetype=bash"
})
