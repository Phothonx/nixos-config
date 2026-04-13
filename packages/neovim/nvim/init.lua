vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")

require("lazy").setup({
  read_only = true,
  spec = { { import = "plugins" }, },
  performance = {
    reset_packpath = false,
    rtp = {
      reset = false,
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  rocks = { enabled = false },
  pkg = { enabled = false },
  install = { missing = false },
  change_detection = { enabled = false },
  checker = { enabled = false },
  ui = { border = "single", },
  defaults = { lazy = false, },
})

require("config.lsp")
require("config.keymaps")
