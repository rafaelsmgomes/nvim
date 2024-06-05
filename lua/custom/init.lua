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

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if require("cmp").visible() then
      require("cmp").mapping.close()
    end
  end
})


-- only add conceallevel if it's a markdown file
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "set conceallevel=1"
  -- command = "set conceallevel=1 tabstop=4 shiftwidth=4 softtabstop=4"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal spell"
})

vim.g['text_conceal'] = "gm"

vim.api.nvim_set_hl(0, "markdownBold", { fg = "#eba0ac" })
vim.api.nvim_set_hl(0, "markdownItalic", { fg = "#f9e2af", italic = true })
vim.api.nvim_set_hl(0, "markdownH2", { fg = "#94e2d5" })
vim.api.nvim_set_hl(0, "markdownH3", { fg = "#cba6f7" })
vim.api.nvim_set_hl(0, "markdownH4", { fg = "#89dceb" })
-- vim.api.nvim_set_hl(0, "markdownH5", { fg = "#f9e2af", italic = true })
-- vim.api.nvim_set_hl(0, "ObsidianStarred", { fg = "#eed49f", italic = true })


--
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "~/Documents/Obsidian Vault/",
--   command = "setlocal conceallevel=1 tabstop=4 shiftwidth=4 softtabstop=4"
-- })


-- opt.expandtab = true
-- opt.shiftwidth = 2
-- opt.smartindent = true
-- opt.tabstop = 2
-- opt.softtabstop = 2
--
