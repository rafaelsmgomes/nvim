--@diagnostic disable-next-line: different-requires
local lspconfig = require "lspconfig"
local nlspsettings = require("nlspsettings")
local util = require "lspconfig/util"

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

nlspsettings.setup({
  config_home = vim.fn.stdpath('config') .. './nlspsettings',
  local_settings_dir = '.nlsp-settings',
  local_settings_root_markers_fallback = { ".git" },
  append_default_schemas = true,
  loader = 'json'
})

local servers = {
  "astro",
  "graphql",
  -- "sqlls",
  "dockerls",
  "nil_ls",
  "jsonls",
  "tflint",
  "docker_compose_language_service",
  "asm_lsp",
  "cmake",
  "html",
  -- "terraform_lsp",
}

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
      preferences = {
        disableSuggestions = true
      }
    }
  }
end

lspconfig.terraformls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "tf", "hcl", "terraform" },
}

lspconfig.markdown_oxide.setup({
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
})


lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "css", "scss", "javascript", "typescript", "astro", "javascriptreact", "typescriptreact", "rust" },
  init_options = {
    userLanguages = {
      rust = "html",
    }
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "axisLineClassName", "tickClassName" },
      includeLanguages = {
        rust = "rust",
        "*.rs = rust",
      }
    }
  }
}

lspconfig["emmet_language_server"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "css",
    "html",
    "javascriptreact",
    "sass",
    "scss",
    "typescriptreact",
    "tmpl",
    "templates",
    "templ",
  },
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    }
  }
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl", "tmpl", "gohtml" },
  root_dir = util.root_pattern("go_work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedParams = true,
      },
    },
  },
}

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signarureHelpProvider = false
    on_attach(client, bufnr)
  end,
  -- cmd = { "clangd", "--offset-encoding=utf-8" },
  capabilities = capabilities,
}

lspconfig.sqlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "sql-language-server", "up", "--method", "stdio" }
}
