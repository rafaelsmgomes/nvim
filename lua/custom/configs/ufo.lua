vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.keymap.set("n", "zr", require("ufo").openAllFolds)
vim.keymap.set("n", "zm", require("ufo").closeAllFolds)
vim.keymap.set("n", "zK", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = "Peek fold" })

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true,
-- }
--
-- local language_servers = require("lspconfig").util.available_servers()
-- for _, ls in pairs(language_servers) do
--   require("lspconfig")[ls].setup {
--     capabilities = capabilities,
--   }
-- end

require("ufo").setup({
  provider_selector = function ()
    return { 'lsp', 'indent' }
  end
})
