local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local options = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
        -- rustfmt = {
        --   overrideCommand = {"leptosfmt", "--stdin", "--rustfmt"}
        -- }
      },
    },
  },
}

return options

