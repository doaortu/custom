vim.api.nvim_create_autocmd("UIEnter", {
  desc = 'Cursor behave like normal editor',
  callback = function ()
    vim.cmd([[runtime mswin.vim]])
  end
})

vim.api.nvim_create_autocmd("UIEnter", {
  desc = 'Set folding behaviour (so we can fold code by using "zc" and "za")',
  callback = function ()
    vim.cmd([[set foldmethod=indent]])
    vim.cmd([[set foldlevel=99]]) -- when open file, default to open all folds
    -- vim.cmd([[set foldmethod=expr]]) -- use this if you want to use treesitter folding
    -- vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]]) -- and this

  end
})

-- local swift_lsp = vim.api.nvim_create_augroup("swift_lsp", { clear = true })
--  vim.api.nvim_create_autocmd("FileType", {
--  	pattern = { "swift" },
--  	callback = function()
--  		local root_dir = vim.fs.dirname(vim.fs.find({
--  			"Package.swift",
--  			".git",
--  		}, { upward = true })[1])
--  		local client = vim.lsp.start({
--  			name = "sourcekit-lsp",
--  			cmd = { "sourcekit-lsp" },
--  			root_dir = root_dir,
--  		})
--  		vim.lsp.buf_attach_client(0, client)
--  	end,
--  	group = swift_lsp,
--  })
