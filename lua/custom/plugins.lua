local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- cpp
        "clangd",
        "clang-format",
        -- "codelldb",
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
      "windwp/nvim-ts-autotag",
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
      autotag = {
        enable = true
      }
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
    dependencies = "github/copilot.vim",
    config = function()
      -- require("core.utils").load_mappings("copilot")
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
    lazy = false,
    config = function()
      return require("custom.configs.ufo")
    end
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
      "gbprod/none-ls-shellcheck.nvim",
    },
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
    dependencies = {
      "folke/neodev.nvim"
    },

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
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
    lazy = false,
  },
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
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go",
    },
    config = function()
      require("custom.configs.dap")
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
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
    "Civitasv/cmake-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      require("cmake-tools").setup({})
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
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/Obsidian Vault/",
        }
      },
      daily_notes = {
        folder = "daily",
        template = "templates/daily.md",
      },
      ui = {
        -- enable = false
        checkboxes = {
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          ["l"] = { char = "", hl_group = "ObsidianPin" },
          ["~"] = { char = "󰜺", hl_group = "ObsidianTilde" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        },
        hl_groups = {
          ObsidianTodo = { fg = "#89ddff", bold = true },
          ObsidianDone = { fg = "#98c379", bold = true },
          ObsidianPin = { fg = "#eed49f", bold = true },
          ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
          ObsidianTilde = { bold = true, fg = "#ff5370" },
          ObsidianBullet = { bold = true, fg = "#89ddff" },
          ObsidianRefText = { underline = true, fg = "#c792ea" },
          ObsidianExtLinkIcon = { fg = "#c792ea" },
          ObsidianTag = { italic = true, fg = "#89ddff" },
          ObsidianBlockID = { italic = true, fg = "#89ddff" },
          ObsidianHighlightText = { bg = "#75662e" },
          Headline2 = { fg = "#94e2d5" },
          markdownH3 = { fg = "#cba6f7" },
          markdownH4 = { fg = "#89dceb" },
        }
      },
      disable_frontmatter = true,
    }
  },
  {
    "folke/trouble.nvim",
    branch = "dev",
    lazy = "Lazy",
    keys = {
      {
        "<leader>xd",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xf",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = {}
  },
  { 'b0o/schemastore.nvim' },
  {
    "jmbuhr/otter.nvim",
    dev = false,
    opts = {
      buffers = {
        set_filetype = false,
        write_to_disk = false,
      },
      lsp = {
        hover = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        }
      },
      strip_wrapping_quote_characters = { "'", '"', "`" },
      -- Otter may not work the way you expect when entire code blocks are indented (eg. in Org files)
      -- When true, otter handles these cases fully. This is a (minor) performance hit
      handle_leading_whitespace = false,
    },
    -- config = function(_, opts)
    --   local otter = require('otter')
    --   otter.setup(opts)
    --   local languages = {'python', "r", "julia", "lua"}
    --   otter.activate(languages, true, true, nil)
    -- end

    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
    }
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim"
    },
    ft = { "quarto" },
    dev = false,
    opts = {
      lspFeatures = {
        languages = { "r", "python", "julia", "bash", "html" },
      },
      -- codeRunner = {
      --   enabled = true,
      --   default_method = "slime"
      -- }
    },

  },
  {
    "jpalardy/vim-slime",
    init = function()
      vim.b['quarto_is_python_chunk'] = false
      Quarto_is_python_chunk = function()
        require('otter.tools.functions').is_otter_language_context 'python'
      end

      vim.cmd [[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
      return [a:text, "\n"]
      else
      return [a:text]
      end
      end
      endfunction
      ]]

      vim.g.slime_target = "tmux"
      vim.g.slime_python_ipython = 1
    end,
    config = function()
      local function mark_terminal()
        vim.g.slime_last_channel = vim.b.terminal_job_id
      end

      local function set_terminal()
        vim.b.slime_config = { jobid = vim.g.slime_last_channel }
      end
    end
  },
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    opts = {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
    },
    event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
    },
  },
  {
    "folke/neodev.nvim",
    opts = {}
  }
}

return plugins
