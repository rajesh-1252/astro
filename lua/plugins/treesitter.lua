-- Customize Treesitter
if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "javascript",
      "go",
      "markdown",
      "typescript",
      -- add more arguments for adding more treesitter parsers
    },
  },
}
