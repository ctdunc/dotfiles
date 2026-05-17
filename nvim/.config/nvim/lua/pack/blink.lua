vim.pack.add({
  {
    src = "https://github.com/saghen/blink.lib",
    name = "blink.lib",
  },
  {
    src = "https://github.com/saghen/blink.cmp",
    name = "blink.cmp",
  },
})
local cmp = require("blink.cmp")
cmp.build():wait(60000)
cmp.setup({
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
  fuzzy = { implementation = "prefer_rust" },
})
