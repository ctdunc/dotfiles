vim.pack.add({
  { src = "https://github.com/folke/trouble.nvim", name = "trouble" },
})

require("trouble").setup({ win = { position = "right", size = 0.25 } })
