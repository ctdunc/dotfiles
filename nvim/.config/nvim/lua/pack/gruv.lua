vim.pack.add({
  {
    src = "https://github.com/ellisonleao/gruvbox.nvim",
    name = "gruvbox",
  },
})
require("gruvbox").setup({
  underline = true,
  bold = true,
  italic = {
    strings = false,
    emphasis = false,
    comments = false,
    operators = false,
    folds = true,
  },
  inverse = true,
  contrast = "hard",
  overrides = { NormalFloat = { bg = "#282828" } },
  transparent_mode = false,
  dim_inactive = false,
})
vim.cmd.colorscheme("gruvbox")
