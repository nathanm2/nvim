-- A modified version of LazyVim's `format.lua`
--

local M = {}

M.opts = nil

function M.enabled()
  return vim.g.AutoFormat == 1
end

-- Toggle the 'AutoFormat' setting:
function M.toggle()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    vim.g.AutoFormat = 1
  else
    vim.g.AutoFormat = (vim.g.AutoFormat == 0 and 1 or 0)
  end
  if vim.g.AutoFormat == 1 then
    print("Enabled format on save")
  else
    print("Disabled format on save")
  end
end

---@param opts? {force?:boolean}
function M.format(opts)
  local buf = vim.api.nvim_get_current_buf()

  if vim.b.autoformat == false and not (opts and opts.force) then
    return
  end

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
  vim.g.AutoFormat = (opts.autoformat and 1 or 0)
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("LspFormat", {}),
    callback = function()
      if M.enabled() then
        M.format()
      end
    end,
  })
end

return M
