local options = {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",

        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["am"] = "@call.outer",
        ["im"] = "@call.inner",

        ["as"] = "@class.outer",
        ["is"] = "@class.inner",

        ["al"] = "@loop.outer",
        ["ai"] = "@loop.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]s"] = "@class.outer",
        ["]i"] = "@conditional.outer",
        ["]l"] = "@loop.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]S"] = "@class.outer",
        ["]I"] = "@conditional.outer",
        ["]L"] = "@loop.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[s"] = "@class.outer",
        ["[i"] = "@conditional.outer",
        ["[l"] = "@loop.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[S"] = "@class.outer",
        ["[I"] = "@conditional.outer",
        ["[L"] = "@loop.outer",
      },
    },
  }
}

local ts_repeat = require("nvim-treesitter.textobjects.repeatable_move")
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_opposite)

-- WARN: repeatable mappings may not be necessary
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat.builtin_T)

return options
