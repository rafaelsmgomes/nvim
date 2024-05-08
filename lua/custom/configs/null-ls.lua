local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting = null_ls.builtins.formatting

local sources = {
  formatting.clang_format,
  formatting.prettierd.with {
    extra_filetypes = { "astro", "json", "html", "tmpl", "toml" },
    -- condition = function ()
    --   if vim.bo.filetype == "markdown" then
    --     return false
    --   end
    --   return true
    -- end
  },
  formatting.alejandra,
  formatting.gofmt,
  formatting.goimports_reviser,

  require("none-ls.diagnostics.eslint_d"),
  require("none-ls.diagnostics.ruff"),
  require("none-ls-shellcheck.diagnostics"),
}

null_ls.setup {
  debug = true,
  sources = sources,
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
          vim.lsp.buf.format { async = false }
        end,
      })
    end
  end,
}
