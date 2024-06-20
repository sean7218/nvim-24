vim.api.nvim_create_user_command(
  "CMake",
  function()
    vim.cmd("!cd build && cmake .. && make && ./my_program")
  end,
  { nargs = 0 }
)

return require("pencilbox")

