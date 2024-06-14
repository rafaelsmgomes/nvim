vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldmethod = 'manual'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local language_servers = require("lspconfig").util.available_servers()
for _, ls in pairs(language_servers) do
  require("lspconfig")[ls].setup {
    capabilities = capabilities,
  }
end

require("ufo").setup({
  provider_selector = function()
    return { 'lsp', 'indent' }
  end
})
