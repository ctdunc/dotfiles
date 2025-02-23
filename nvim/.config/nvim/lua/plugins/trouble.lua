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
