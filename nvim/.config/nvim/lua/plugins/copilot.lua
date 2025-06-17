return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      server_opts_overrides = {
        settings = {
          advanced = { debug = { acceptSelfSignedCertificate = true } },
        },
      },
    })
  end,
}
