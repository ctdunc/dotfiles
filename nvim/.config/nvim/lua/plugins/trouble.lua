vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd([[Trouble qflist open]])
  end,
})
return {
  "folke/trouble.nvim",
  opts = {
    focus = true,
    win = {
      type = "split",
      position = "right",
      relative = "editor",
      size = { width = 90 },
      -- winhighlight = "Normal:Normal",
    },
    preview = {
      type = "split",
      position = "bottom",
      relative = "win",
      size = { height = 0.4 },
    },
  },
}
