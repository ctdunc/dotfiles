vim.pack.add({
  { src = "https://github.com/nvim-telescope/telescope.nvim", name = "telescope" },
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim", name = "telescope-ui" },
  -- { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", name = "telescope-fzf" },
})
local telescope = require("telescope")
local teletrouble = require("trouble.sources.telescope")
telescope.setup({
  extensions = {
    ["ui-select"] = { require("telescope.themes").get_dropdown() },
  },
  defaults = {
    -- set here, not in key.lua as these only work in telescope windows.
    mappings = {
      i = { ["<c-t>"] = teletrouble.open },
      n = { ["<c-t>"] = teletrouble.open },
    },
  },
})
telescope.load_extension("ui-select")
