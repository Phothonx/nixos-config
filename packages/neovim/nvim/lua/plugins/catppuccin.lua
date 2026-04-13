require("catppuccin").setup({
  transparent_background = true,
  mini = {
    indentscope_color = "comment",
  },
  custom_highlights = function(_)
    return {
      Pmenu = { bg = "#1E1E2E" },
    }
  end,
})

vim.cmd.colorscheme("catppuccin")
