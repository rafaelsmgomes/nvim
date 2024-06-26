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
        "lua-language-server",
        "typescript-language-server",
        "prettierd",
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
        "markdown_inline",
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
      "theHamsta/nvim-dap-virtual-text",
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
      local opts = require("custom.configs.dap-ui")
      dapui.setup(opts)
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
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup({})
    end
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
      vim.keymap.set({ 'n' }, 's', '<Plug>(leap-forward)')
      vim.keymap.set({ 'n' }, 'S', '<Plug>(leap-backward)')
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
    -- opts = function()
    --   return require("custom.configs.nvim-treesitter")
    -- end
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
        -- {
        --   name = "personal",
        --   path = "~/Documents/Obsidian Vault/",
        -- },
        -- {
        --   name = "buf-parent",
        --   path = function()
        --     return vim.fs.dirname(vim.api.nvim_buf_get_name(0))
        --   end,
        -- },
        {
          name = "work",
          path = "~/obsidian/Personal/"
        }
      },
      follow_url_func = function(url)
        vim.fn.jobstart({ "open", url })
      end,
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      ui = {
        -- enable = false
        checkboxes = {
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          -- ["!"] = { char = "", hl_group = "ObsidianExclamation" },
          ["!"] = { char = "", hl_group = "ObsidianExclamation" },
          -- ["s"] = { char = "", hl_group = "ObsidianStar" },
          ["l"] = { char = "", hl_group = "ObsidianPin" },
          ["~"] = { char = "󰜺", hl_group = "ObsidianTilde" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ['?'] = { char = "", hl_group = "ObsidianQuestion" },
        },
        hl_groups = {
          ObsidianTodo = { fg = "#89ddff", bold = true },
          ObsidianQuestion = { bold = true, fg = "#ff5370" },
          ObsidianDone = { fg = "#98c379", bold = true },
          ObsidianPin = { fg = "#eed49f", bold = true },
          ObsidianStar = { fg = "#eed49f", bold = true },
          ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
          ObsidianExclamation = { bold = true, fg = "#ff5370" },
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
      disable_frontmatter = function()
        local filepath = vim.fn.expand("%:p")
        local path_includes_dir = function(filepath, directory)
          return filepath:find(directory, 1, true) ~= nil
        end
        local disable_in_dirs = { "daily", "templates", "Templates", }
        for _, dir in ipairs(disable_in_dirs) do
          if path_includes_dir(filepath, dir) then
            return true
          end
        end
        return false
      end,
      note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
          suffix = title:gsub(" ", "-")
        else
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return suffix .. "-" .. tostring(os.time())
      end,
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },
      daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
        template = '~/obsidian/Personal/templates/daily.md',
      }

    }
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
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    lazy = false,
    branch = "regexp", -- This is the regexp branch, use this for the new version
    config = function()
      require("venv-selector").setup()
    end,
    keys = {
      { ",v", "<cmd>VenvSelect<cr>" },
    },
  },
  {
    "folke/neodev.nvim",
    opts = {}
  },
  {
    "jbyuki/nabla.nvim",
    config = function()
      require("nabla").setup({
        autocmd = { "BufEnter", "BufWinEnter", "TabEnter" },
        enabled = true,
        view = {
          left = "line",
          right = "sign",
        }
      })
    end,
  },
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    event = "BufEnter"
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require('notify').setup()
    end,
    lazy = false
  },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup()
    end,
    lazy = false
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        under_cursor = false
      })
    end,
    event = "BufEnter"
  },
  {
    "tpope/vim-surround",
    lazy = false
  },
  -- {
  --   "gelguy/wilder.nvim",
  --   config = function ()
  --     local wilder = require("wilder")
  --     wilder.setup({
  --       modes = {":", "/", "?"},
  --       next_key = "<C-n>",
  --       previous_key = "<C-p>",
  --     })
  --     wilder.set_option('renderer', wilder.popupmenu_renderer({
  --       highlighter = wilder.basic_highlighter()
  --     }))
  --   end,
  --   lazy = false
  -- }
  {
    "nanotee/sqls.nvim"
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    lazy = false
  },
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim"
    },
    build = function()
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup()
    end,
  },
  {
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup()
    end,
    lazy = false,
  },
  {
    "ThePrimeagen/harpoon",
    config = function ()
      require("harpoon").setup({
        menu = {
          width = 100,
        }
      })
    end
  }
}

return plugins
