--@diagnostic disable-next-line: different-requires
local lspconfig = require "lspconfig"
local nlspsettings = require("nlspsettings")
local util = require "lspconfig/util"

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local servers = {
  "astro",
  "graphql",
  -- "sqlls",
  "dockerls",
  "nil_ls",
  "jsonls",
  "marksman",
  "tflint",
  "docker_compose_language_service",
  "asm_lsp",
  "cmake",
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

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "axisLineClassName", "tickClassName" },
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
    -- "rust",
    "tmpl",
    "templates",
    "templ",
    "terraform_lsp",
  }
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
  capabilities = capabilities,
}

lspconfig.sqlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "sql-language-server", "up", "--method", "stdio" }
}

-- nlspsettings.setup({
--   config_home = vim.fn.stdpath('config') .. './nlspsettings',
--   local_settings_dir = '.nlspsettings',
--   local_settings_root_markers_fallback = { ".git" },
--   append_default_schemas = true,
--   loader = 'json'
-- })

-- local project_config = vim.fn.getcwd() .. "/project_config.lua"
-- if vim.fn.filereadable(project_config) == 1 then
--   local project_settings = dofile(project_config)
--   local default_setting = require("custom.configs.lspconfig").tailwindcss
--   local merged_config = require('custom.utils').merge_configs(default_setting, project_settings)
--   require("lspconfig").tailwindcss.setup(merged_config)
-- end
