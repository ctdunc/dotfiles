return {
  "renerocksai/telekasten.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    -- See `:help telescope` and `:help telescope.setup()`
    require("telekasten").setup({
      home = vim.fn.expand("~/notes/"),
      dailies = vim.fn.expand("~/notes/daily"),
      template_new_daily = vim.fn.expand("~/notes/.templates/daily.md"),
    })

    vim.keymap.set("n", "<leader>nd", "<cmd>Telekasten goto_today<CR>")
    vim.keymap.set("n", "<leader>nw", "<cmd>Telekasten goto_thisweek<CR>")
    vim.keymap.set("n", "<leader>nn", "<cmd>Telekasten new_note<CR>")
    vim.keymap.set("n", "<leader>ngd", "<cmd>Telekasten find_daily_notes<CR>")
    vim.keymap.set("n", "<leader>ngw", "<cmd>Telekasten find_weekly_notes<CR>")
    vim.keymap.set("n", "<leader>ngg", "<cmd>Telekasten find_notes<CR>")
    vim.keymap.set("n", "<leader>ntt", "<cmd>Telekasten toggle_todo<CR>")

    vim.keymap.set("n", "gd", "<cmd>Telekasten follow_link<CR>")
  end,
}
