local dap = require("dap")
print("Loading dap.lua")
require("core.utils").load_mappings "dap"
require("dap-go").setup()

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = { "--liblldb", "/usr/local/Cellar/llvm/17.0.6_1/lib/liblldb.dylib", "--port", "${port}" },
    -- args = { "--liblldb", "Users/rafaelgomes/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib", "--port", "${port}" }
  }
}


dap.configurations.c = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    host = "127.0.0.1",
    port = 34567,
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {}
  }
}
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c



