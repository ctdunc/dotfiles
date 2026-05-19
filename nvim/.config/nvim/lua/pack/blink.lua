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
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "dadbod" },
    providers = {
      dadbod = {
        name = "Dadbod",
        module = "vim_dadbod_completion.blink",
        score_offset = 100,
      },
    },
  },
  fuzzy = { implementation = "prefer_rust" },
})
