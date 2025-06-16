return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()
    
    local lspconfig = require("lspconfig")
    
    require("mason-lspconfig").setup({
      ensure_installed = { "clangd" },
      automatic_installation = true,
      handlers = {
        function(server_name)
          lspconfig[server_name].setup({})
        end,
      },
    })
  end,
  lazy = false,
}