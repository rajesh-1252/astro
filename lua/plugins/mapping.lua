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
          ["<leader>lx"] = { "<cmd>Telescope diagnostics<CR>", desc = "Open Workspace Diagnostics (Telescope)" },
          ["YY"] = { "va{Vy}", desc = "copy functions" },

          -- Keymap to open current buffer diagnostics in Telescope
          ["<leader>lX"] = {
            "<cmd>Telescope diagnostics bufnr=0<CR>",
            desc = "Open Current Buffer Diagnostics (Telescope)",
          },
          ["<leader>lo"] = { "<cmd>e ~/.config/nvim/vim_shortcuts.md<CR>", desc = "Open Vim Shortcuts" },
          ["<leader>lc"] = {
            "<cmd>!tmux new-session -d -s nvim_config<CR>",
            desc = "Create new tmux session: nvim_config",
          },

          ["<leader>ln"] = {
            function()
              require("telescope.builtin").find_files {
                prompt_title = "Find Notes",
                cwd = "~/Desktop/knowlegeDB/1.quickNotes", -- Set directory to ~/notes
                hidden = true, -- Show hidden files
              }
            end,
            desc = "Find Notes",
          },
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
            -- function() vim.lsp.buf.hover() end,
            -- desc = "Hover symbol details",
            --
            function()
              -- Check if a floating window is open, and focus it
              for _, win in pairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_win_get_config(win).relative ~= "" then
                  vim.api.nvim_set_current_win(win)
                  return
                end
              end

              -- Get the word under the cursor
              local cursor_word = vim.fn.expand "<cword>"
              local cursor_pos = vim.api.nvim_win_get_cursor(0)
              local line = cursor_pos[1] - 1
              local col = cursor_pos[2]

              -- Get diagnostics at the exact cursor position
              local diagnostics = vim.diagnostic.get(0, { lnum = line })
              for _, diag in ipairs(diagnostics) do
                if diag.col <= col and col < diag.end_col then
                  vim.diagnostic.open_float()
                  return
                end
              end

              -- If no diagnostic found, check LSP hover
              local clients = vim.lsp.get_active_clients { bufnr = 0 }
              if #clients > 0 then vim.lsp.buf.hover() end
            end,
            desc = "Smart hover (diagnostic on word, LSP hover, focus floating window)",
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
