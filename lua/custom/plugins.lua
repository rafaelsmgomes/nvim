local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "rust-analyzer",
        "typescript-language-server",
        "graphql-language-service-cli",
        "gopls",
        "astro-language-server",
        "emmet-language-server",
        "tailwindcss-language-server",
        "sqlls",
        "pyright",
        "black",
        "mypy",
        "ruff",
        "stylua",
        "prettierd",
        "eslint_d",
        "asm-lsp",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",
        "markdown",
        "rust",
        "go",

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
        "terraform",
        "nasm",
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
    },
  },
  { "github/copilot.vim", lazy = false },
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
    init = function()
      require("core.utils").load_mappings "dap"
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
  },
}

return plugins
