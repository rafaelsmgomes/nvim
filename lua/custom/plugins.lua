local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- cpp
        "clangd",
        "clang-format",
        "codelldb",
        "cmake-language-server",
        -- rust
        "rust-analyzer",
        -- ts
        "typescript-language-server",
        "graphql-language-service-cli",
        "astro-language-server",
        "emmet-language-server",
        "tailwindcss-language-server",
        "sqlls",
        "pyright",
        "black",
        "mypy",
        "prettierd",
        "gopls",
        "ruff",
        "stylua",
        "eslint_d",
        "asm-lsp",
      },
      filetype_extensions = {
        hcl = { "terraform", "hcl" },
      }
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",
        "markdown",
        "rust",
        "go",
        "cpp",

        -- web dev
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",

        "tsx",
        "json",
        "jsonc",
        "astro",
        "graphql",
        "prisma",
        "nix",
        "toml",
        "yaml",
        "hcl",
        "nasm",
        "sql",
        "vimdoc",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<s-l>",
          node_incremental = "<s-l>",
          scope_incremental = "<s-s>",
          node_decremental = "<s-h>",
        },
      },
    }
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    opts = function()
      return require("custom.configs.nvim-treesitter-textobjects")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },
  { "github/copilot.vim", lazy = false },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    opts = function()
      return require "custom.configs.nvim-silicon"
    end,
    config = function(_, opts)
      require("silicon").setup(opts)
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    -- lazy = false,
    config = function ()
      require "custom.configs.ufo"
    end
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "op read op://Personal/ChatGPT-API/credential",
      })
    end
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    ft = { "go", "python" },
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "tamago324/nlsp-settings.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    lazy = false,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  { "tpope/vim-fugitive", event = "BufRead" },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      -- vim.g.rustfmt_command = "leptosfmt --stdin | rustfmt"
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("core.utils").load_mappings "dap"
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {}
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      crates.show()
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  -- TODO: investigate what is this one for
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, { name = "crates" })
      return M
    end,
  },
  { "jparise/vim-graphql", lazy = false },
  {
    "wuelnerdotexe/vim-astro",
    ft = "astro",
    init = function()
      -- Astro configuration variables
      vim.g.astro_typescript = "enable"
      vim.g.astro_stylus = "disable"
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    lazy = false,
    opts = {},
    config = function()
      require("symbols-outline").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    lazy = false,
    opts = {},
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "ggandor/leap.nvim",
    event = "BufRead",
    dependencies = {
      "tpope/vim-repeat",
    },
    lazy = false,
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup {
        multiline_threshold = 1,
      }
    end,
    event = "BufRead",
  },
  {
    "drybalka/tree-climber.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = function()
      return require("custom.configs.nvim-treesitter")
    end
  },
}

return plugins
