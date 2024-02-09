local M = {}

M.disabled = {
  n = {
    ["S"] = { "" }
  }
}

M.abc = {
  n = {
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
    ["<leader>gs"] = { "<cmd>Git<cr>", "Git Status" },
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
  },
  v = {
    ["<A-j>"] = { ":m '>+1<CR>gv=gv", "Move selected lines down" },
    ["<A-k>"] = { ":m '<-2<CR>gv=gv", "Move selected lines up" },
    ["<leader>y"] = { '"+y', "Yank into clippboard" },
    ["<leader>d"] = { '"_d', "Delete into the void register" },
    ["<leader>Y"] = { '"+Y', "Yank into system clippboard" },
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
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

return M
