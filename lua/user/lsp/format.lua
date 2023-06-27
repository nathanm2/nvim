
local M = {}

M.opts = nil

function M.enabled()
  return M.opts.autoformat
end

-- Toggle the 'autoformat' setting:
function M.toggle()
  M.opts.autoformat = not M.opts.autoformat
  if M.opts.autoformat then
    print("Enabled format on save")
  else
    print("Disabled format on save")
  end
end

-- Gets all lsp clients that support formatting
-- and have not disabled it in their client config
---@param client lsp.Client
function M.supports_format(client)
  if
    client.config
    and client.config.capabilities
    and client.config.capabilities.documentFormattingProvider == false
  then
    return false
  end
  return client.supports_method("textDocument/formatting") or
  client.supports_method("textDocument/rangeFormatting")
end

function M.setup(opts)
  M.opts = opts
end

return M
