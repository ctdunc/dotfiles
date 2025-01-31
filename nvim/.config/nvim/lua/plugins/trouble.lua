return {
  "folke/trouble.nvim",
  opts = {
    focus = true,
    win = {
      type = "split",
      position = "right",
      relative = "editor",
      size = { width = 100 },
      winhighlight = "Normal:Normal",
    },
    preview = {
      type = "split",
      position = "bottom",
      relative = "win",
      --relative = "cursor",
      --size = { width = 88, height = 20 },
      --position = { 0, 90 },
    },
  },
}
