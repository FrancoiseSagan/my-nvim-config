-- ~/.config/nvim/lua/plugins/tokyo.lua
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night",  -- 可选: "storm", "day", "moon"
    transparent = false,
  },
  config = function()
    vim.cmd.colorscheme("tokyonight")
  end,
}
