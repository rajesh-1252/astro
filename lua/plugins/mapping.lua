return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          -- ["L"] = { "<cmd>bn<cr>", desc = "Buffer next" },
          -- ["H"] = { "<cmd>bp<cr>", desc = "Buffer prev" },
          --
          L = {
            function() require("astrocore.buffer").nav(vim.v.count1) end,
            desc = "Next buffer",
          },
          H = {
            function() require("astrocore.buffer").nav(-vim.v.count1) end,
            desc = "Previous buffer",
          },
          ["<A-j>"] = { ":m .+1<CR>==", desc = " move down" },
          ["<A-k>"] = { ":m .-2<CR>==", desc = "move up" },
          ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          ["<leader>ll"] = { "za", desc = "Toggle fold" },
          ["<Leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Pick to close",
          },
          -- tables with the `name` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { name = "Buffers" },
          -- quick save
          ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
        v = {
          ["<A-j>"] = { ":m '>+1<CR>gv=gv", desc = " move down" },
          ["<A-k>"] = { ":m '>-2<CR>gv=gv", desc = "move up" },
        },
        i = {
          ["<A-k>"] = { "<Esc>:m .-2<CR>==gi", desc = "move up" },
          ["<A-j>"] = { "<Esc>:m .+1<CR>==gi", desc = " move down" },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          ["<leader>ll"] = { "za", desc = "Toggle fold" },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
