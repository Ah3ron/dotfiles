-- return {
--   "nyoom-engineering/oxocarbon.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.opt.background = "dark"
--     vim.cmd("colorscheme oxocarbon")
--     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--     -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--     vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
--   end,
-- }

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      float = {
        transparent = true,
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-nvim",
    },
  },
}
