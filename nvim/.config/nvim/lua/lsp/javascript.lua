local MIN_MAJOR = 18
-- all my homies hate ubuntu for having such an old node version.
-- this tries to do nice resolution
local function node_major(bin)
  local out = vim.fn.system({ bin, "--version" })
  if vim.v.shell_error ~= 0 then
    return nil
  end
  return tonumber(out:match("v(%d+)"))
end

local function node_bin_dir()
  local sys = vim.fn.exepath("node")
  if sys ~= "" then
    local major = node_major(sys)
    if major and major >= MIN_MAJOR then
      return nil
    end
  end
  local nvm = vim.fn.glob(vim.fn.expand("~/.nvm/versions/node/*/bin/node"))
  local candidates = vim.split(nvm, "\n", { trimempty = true })
  table.sort(candidates)
  local newest = candidates[#candidates]
  return newest and vim.fs.dirname(newest) or nil
end

local cmd_env = nil
local bin_dir = node_bin_dir()
if bin_dir then
  cmd_env = { PATH = bin_dir .. ":" .. vim.env.PATH }
end

-- Note: typescript-language-server does not support TypeScript 7+, which
-- removed tsserver.js from lib/. Install typescript@5 globally under nvm.
---@type vim.lsp.Config
vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  cmd_env = cmd_env,
  filetypes = { "javascript", "typescript" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})
