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

vim.api.nvim_set_hl(0, 'Visual', { bg = '#4f5b66' })

vim.api.nvim_set_hl(0, "markdownBold", { fg = "#eba0ac" })
vim.api.nvim_set_hl(0, "markdownItalic", { fg = "#f9e2af", italic = true })
vim.api.nvim_set_hl(0, "markdownH2", { fg = "#94e2d5" })
vim.api.nvim_set_hl(0, "markdownH3", { fg = "#cba6f7" })
vim.api.nvim_set_hl(0, "markdownH4", { fg = "#89dceb" })
-- vim.api.nvim_set_hl(0, "markdownH5", { fg = "#f9e2af", italic = true })
-- vim.api.nvim_set_hl(0, "ObsidianStarred", { fg = "#eed49f", italic = true })

vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("WinResize", { clear = true }),
  pattern = "*",
  command = "windcmd =",
  desc = "Auto-resize windows on terminal buffer resize"
})



vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("vertical_help", { clear = true }),
  pattern = "help",
  callback = function()
    vim.bo.bufhidden = "unload"
    vim.cmd.wincmd("L")
    vim.cmd.wincmd("=")
  end

})

vim.keymap.set("n", "<leader>cp", function()
  local full_path = vim.fn.expand("%:p")
  vim.fn.setreg("+", full_path)
  require("notify")("Copied path to clipboard", "info", { title = "Neovim" })
end, { noremap = true })
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
vim.g.db_ui_debug = 1
vim.g.db_ui_log_file = vim.fn.expand('~/.config/nvim/dbui.log')

vim.g.copilot_no_tab_map = true

-- set up spectre keymappings
vim.keymap.set('n', "<leader>ss", function() require("spectre").toggle() end, { desc = "Search current word" })
vim.keymap.set('n', "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end,
  { desc = "Search current word" })
vim.keymap.set('v', "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end,
  { desc = "Search current word" })
vim.keymap.set('n', "<leader>sp", function() require("spectre").open_file_search({ select_word = true }) end,
  { desc = "Search on a current file" })
