local M = {}

-- In order to disable a default keymap, use
-- M.disabled = {
--   n = {
--       ["<leader>h"] = "",
--       ["<C-a>"] = ""
--   }
-- }

-- Your custom mappings
M.abc = {
  n = {
    ["<leader>q"] = { function()
        require('telescope.builtin').diagnostics({bufnr = 0})
      end,
      "Diagnostic setloclist",
    },
    ["<leader>fe"] = { "<cmd> Telescope oldfiles cwd_only=v:true <CR>", "Find oldfiles in cwd" },
    ["<leader>ot"] = { "<cmd>call jobstart('x-terminal-emulator')<CR>", "open new dedicated terminal window" },
    ["<leader>."] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "invoke lsp code action" },
    ["<M-.>"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "invoke lsp code action" },
    ["gl"] = { "<CMD>silent execute '!xdg-open ' .. shellescape(expand('<cfile>'), v:true)<CR>", "Open link in browser" },
    ['gr'] = { function()
      require('telescope.builtin').lsp_references()
    end,
      "Open LSP references" },
    ["<leader>rs"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename variable (scoped, to all occurence)" }
  },

  i = {
    ["<M-.>"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "invoke lsp code action" },
  },
  t = {
    ["<leader><Esc>"] = { "<C-\\><C-n>", "exit terminal mode" },
  }
}

return M
