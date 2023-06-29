-- A modified version of LazyVim's `format.lua`
--

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

---@param opts? {force?:boolean}
function M.format(opts)
  local buf = vim.api.nvim_get_current_buf()
  local formatters = M.get_formatters(buf)
  local client_ids = vim.tbl_map(function(client)
    return client.id
  end, formatters)

  if #client_ids == 0 then
    return
  end

  vim.lsp.buf.format({
    bufnr = buf,
    filter = function(client)
      return vim.tbl_contains(client_ids, client.id)
    end,
  })
end

-- Gets all lsp clients that support formatting.
function M.get_formatters(bufnr)
  local ret = {}
  local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if M.supports_format(client) then
      table.insert(ret, client)
    end
  end
  return ret
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
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("LspFormat", {}),
    callback = function()
      if M.opts.autoformat then
        M.format()
      end
    end,
  })
end

return M
