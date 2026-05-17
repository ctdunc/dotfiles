vim.g.mapleader = " "

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Go to previous [D]iagnostic message" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {})

-- lsp
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "K", vim.lsp.buf.hover)

-- telescope shortcuts
local tscp = require("telescope")
local tscp_bltn = require("telescope.builtin")

vim.keymap.set("n", "<leader>sg", tscp_bltn.live_grep)
vim.keymap.set("n", "<leader>sf", tscp_bltn.find_files)

-- telescope lsp-specific
vim.keymap.set("n", "gd", tscp_bltn.lsp_definitions)
vim.keymap.set("n", "gr", tscp_bltn.lsp_references)
vim.keymap.set("n", "<leader>ds", tscp_bltn.lsp_document_symbols)
vim.keymap.set("n", "<leader>ws", tscp_bltn.lsp_dynamic_workspace_symbols)

-- reserve <leader>g* for git-related operations!
