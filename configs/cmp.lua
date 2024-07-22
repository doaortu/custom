local cmp = require "cmp"
local options = require("plugins.configs.cmp")

options.mapping["<Down>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    -- elseif require("luasnip").expand_or_jumpable() then
    --   vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
    else
      fallback()
    end
  end, {
    "i",
    -- "s",
  })

options.mapping["<Up>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    -- elseif require("luasnip").jumpable(-1) then
    --   vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
    else
      fallback()
    end
  end, {
    "i",
    -- "s",
  })

options.experimental = {
  ghost_text = true,
}

-- table.insert(options.sources, 1, {name = "copilot"})
table.insert(options.sources, 1, {name = "codeium"})

return options
-- cmp.setup(options)
