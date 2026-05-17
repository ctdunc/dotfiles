vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.statusline",
    name = "mini.statusline",
  },
})
local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })
statusline.section_location = function()
  return "%2l:%-2v"
end
