vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")

require("plugins.catppuccin")
require("plugins.mini")
require("plugins.snacks")
require("plugins.treesitter")
require("plugins.blink-cmp")
require("plugins.flash")
require("plugins.iron")
require("plugins.coqtail")
require("plugins.vimwiki")
require("plugins.which-key")

require("config.lsp")
require("config.keymaps")
