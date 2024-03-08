local opts = {
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
    "hcl",
    "nasm",
    "sql",
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
return opts
