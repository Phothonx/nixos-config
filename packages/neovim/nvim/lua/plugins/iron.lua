vim.api.nvim_create_autocmd("FileType", {
  pattern = "ocaml",
  callback = function()
    local iron = require("iron.core")

    iron.setup({
      config = {
        scratch_repl = true,
        repl_definition = {
          ml = { command = { "utop" } },
          py = { command = { "python" } },
        },
        repl_open_cmd = "vertical botright 80 split",
      },
      keymaps = {
        send_motion = "sc",
        visual_send = "sc",
        send_file = "sf",
        send_line = "sl",
        send_until_cursor = "su",
        send_mark = "sm",
        mark_motion = "mc",
        mark_visual = "mc",
        remove_mark = "md",
        cr = "s",
        interrupt = "s",
        exit = "sq",
        clear = "cl",
      },
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true,
    })
  end,
})
