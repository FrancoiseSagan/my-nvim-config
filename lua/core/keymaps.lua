local keymap = vim.keymap.set

-- LSP 诊断相关快捷键
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "显示当前行错误详情" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "显示所有错误列表" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "跳转到上一个错误" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "跳转到下一个错误" })

-- LSP 功能快捷键（当LSP服务器可用时）
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    keymap("n", "gD", vim.lsp.buf.declaration, opts)
    keymap("n", "gd", vim.lsp.buf.definition, opts)
    keymap("n", "K", vim.lsp.buf.hover, opts)
    keymap("n", "gi", vim.lsp.buf.implementation, opts)
    keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
    keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    keymap("n", "gr", vim.lsp.buf.references, opts)
    keymap("n", "<leader>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
}) 