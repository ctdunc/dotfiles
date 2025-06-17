vim.treesitter.language.register("markdown", "telekasten")
return {
  {
    "tadmccorkle/markdown.nvim",
    ft = { "markdown" },
    opts = {},
  },
  --[[
  {
    dir = "~/code/markdown.nvim/",
    ft = { "markdown" },
    opts = {},
  },
  --]]
  --[[
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },--]]
}
