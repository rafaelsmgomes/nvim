local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  formatting.clang_format,
  formatting.prettierd.with {
    extra_filetypes = { "astro", "json", "html", "tmpl", "toml" },
  },
  -- formatting.terrafmt,
  -- formatting.hclfmt,
  formatting.alejandra,
  formatting.gofmt,
  formatting.goimports_reviser,

  lint.ruff,
  lint.shellcheck,
  lint.eslint_d,
  -- lint.terraform_validate,
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
