require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.move").setup()
require("mini.statusline").setup()
require('mini.trailspace').setup()
require("mini.align").setup()

require("mini.files").setup({
  options = {
    use_as_default_explorer = true,
  },
  windows = {
    width_preview = 50,
  },
  mappings = {
    go_in = "L",
    go_in_plus = "l",
  },
})

require("mini.indentscope").setup({
  draw = {
    delay = 50,
    animation = require("mini.indentscope").gen_animation.none(),
  },
  options = {
    try_as_border = true,
  },
})

require("mini.diff").setup({
  view = {
    style = "sign",
    signs = {
      add = "▍",
      change = "▍",
      delete = "▍",
    },
  },
  delay = {
    text_change = 100,
  },
})

vim.keymap.set("n", "e", function()
  MiniFiles.open(MiniFiles.get_latest_path())
end, { desc = "Open last Files instance" })

vim.keymap.set("n", "E", function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
end, { desc = "Open Files from buffer dir" })

vim.keymap.set("n", "t", function()
  MiniTrailspace.trim()
end, { desc = "Grass cutter" })
