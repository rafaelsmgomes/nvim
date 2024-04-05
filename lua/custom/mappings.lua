local M = {}

M.disabled = {
  n = {
    ["S"] = { "" },
  },
  i = {
    ["<C-r>"] = { "" }
  }
}

-- M.trouble = {
--   n = {
--     ["<leader>xx"] =
--     {
--       "<cmd>Trouble diagnostics toggle<cr>",
--       desc = "Diagnostics (Trouble)",
--     },
--     ["<leader>xd"] =
--     {
--       "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
--       desc = "Buffer Diagnostics (Trouble)",
--     },
--     ["<leader>cs"] =
--     {
--       "<cmd>Trouble symbols toggle focus=false<cr>",
--       desc = "Symbols (Trouble)",
--     },
--     ["<leader>cl"] =
--     {
--       "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
--       desc = "LSP Definitions / references / ... (Trouble)",
--     },
--     ["<leader>xL"] =
--     {
--       "<cmd>Trouble loclist toggle<cr>",
--       desc = "Location List (Trouble)",
--     },
--     ["<leader>xQ"] =
--     {
--       "<cmd>Trouble qflist toggle<cr>",
--       desc = "Quickfix List (Trouble)",
--     },
--   }
-- }

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle breakpoint" },
    ["<leader>dr"] = { "<cmd>lua require('dap').repl.open()<cr>", "Repl" },
    ["<leader>dc"] = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
    ["<leader>dn"] = { "<cmd>lua require('dap').step_over()<cr>", "Step over" },
    ["<leader>di"] = { "<cmd>lua require('dap').step_into()<cr>", "Step into" },
    ["<leader>do"] = { "<cmd>lua require('dap').step_out()<cr>", "Step out" },
    ["<leader>dl"] = { "<cmd>lua require('dap').run_last()<cr>", "Run last" },
  }
}

M.copilot = {
  plugin = true,
  n = {
    ["<leader>cp"] = {
      function()
        local status_output = vim.fn.execute("Copilot status")
        if string.find(status_output, "Enabled") then
          vim.cmd("Copilot disable")
          print(vim.cmd("Copilot status"))
        else
          vim.cmd("Copilot enable")
          print(vim.cmd("Copilot status"))
        end
      end,
      "Toggle Copilot",
    }
  },
  i = {
    ["<C-r>"] = {
      'copilot#Accept("\\<CR>")',
      "Accept copilot suggestions",
      opts = { expr = true, replace_keycodes = false }
    }
  }
}

M.abc = {
  n = {
    ["<leader>ra"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
    ["[d"] = {
      function()
        vim.diagnostic.goto_prev({ float = { border = "rounded" } })
      end,
      "Goto prev",
    },
    ["]d"] = {
      function()
        vim.diagnostic.goto_next({ float = { border = "rounded" } })
      end,
      "Goto next",
    },
    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },
    ["gd"] = {
      "<cmd>Telescope lsp_definitions<CR>",
      "LSP definition",
    },
    ["<leader>rf"] = {
      function()
        local file = vim.fn.expand "%"
        vim.cmd("silent !leptosfmt " .. file)
      end,
      "format using leptosfmt",
    },
    ["gr"] = {
      "<cmd>Telescope lsp_references<CR>",
      "LSP references",
    },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },

    ["<A-j>"] = { ":m .+1<CR>==", "move line down" },
    ["<A-k>"] = { ":m .-2<CR>==", "move line up" },
    -- { ["<leader>u"] = {function () end, "Toggle Undotree"} }
    ["<leader>gs"] = { "<cmd>Neogit<cr>", "Git Status" },
    ["<leader>y"] = { '"+y', "Yank into clippboard" },
    ["<leader>Y"] = { '"+Y', "Yank into system clippboard" },
    ["<leader>d"] = { '"_d', "Delete into the void register" },
    ["<leader>fs"] = { "<cmd>SymbolsOutline<cr>", "Toggle SymbolsOutline" },
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },
    ["<C-c>"] = { "<cmd>:nohl<cr>" },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },
    ["<leader>lg"] = { ":LazyGit<CR>", "Open LazyGit" },
    ["<leader>cx"] = { ":w | %bd | e# <CR>", "Delete all saved files" },
    ["<C-p>"] = {
      function()
        require("tree-climber").goto_parent()
      end,
      "Go to parent node",
    },
  },
  i = {
    ["<C-m>"] = {
      function()
        require("cmp").mapping.complete()
      end,
      "call autocomplete suggestions",
    },
    ["<C-c>"] = { "<Esc>", "Leave insert mode" }
  },
  v = {
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
    ["<A-j>"] = { ":m '>+1<CR>gv=gv", "Move selected lines down" },
    ["<A-k>"] = { ":m '<-2<CR>gv=gv", "Move selected lines up" },
    ["<leader>y"] = { '"+y', "Yank into clippboard" },
    ["<leader>d"] = { '"_d', "Delete into the void register" },
    ["<leader>Y"] = { '"+Y', "Yank into system clippboard" },
  },
  x = {
    ["<leader>p"] = { '"_dP', "Paste over without copying content" },
  },
}

M.telescope = {
  n = {
    ["<leader>u"] = { "<cmd>Telescope undo<cr>", "Telescope undotree" },
    ["<leader>gr"] = { "<cmd>Telescope lsp_references<cr>", "Telescope lsp references" },
    ["<leader>ft"] = { "<cmd>TodoTelescope<cr>", "Todo Telescope" },
    ["<leader>fl"] = {
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      "Lsp Workspace Symbols",
    },
    ["<leader>fd"] = {
      function()
        require("telescope.builtin").diagnostics()
      end,
      "Show diagnostics",
    },
    ["<leader>gh"] = {
      function()
        require("telescope.builtin").git_bcommits()
      end
      , "Show file history" },
    ["<leader>gb"] = {
      function()
        require("telescope.builtin").git_branches()
      end
      , "Show git branches" },
  },
}

M.rust = {
  n = {
    ["<leader>rm"] = {
      function()
        require("rust-tools").expand_macro.expand_macro()
      end,
      "Expand macros recursively",
    },
  },
}

M.ufo = {
  n = {
    ["zR"] = { function()
      require("ufo").openAllFolds()
    end, "Open all Folds" },
    ["zr"] = { function()
      require("ufo").openFoldsExceptKinds()
    end, "Open all Folds" },
    ["zM"] = { function()
      require("ufo").closeAllFolds()
    end, "Close all Folds"
    },
    ["zm"] = { function()
      require("ufo").closeFoldsWith()
    end, "Close all Folds"
    },
    ["zK"] = { function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, "Peek fold" },
    ["zv"] = { "za", "Toggle fold" }
  }
}

return M
