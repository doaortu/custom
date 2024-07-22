local null_ls = require "null-ls"

local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

h.make_builtin({
    name = "gofmt",
    method = FORMATTING,
    filetypes = { "go" },
    generator_opts = {
        command = "gofmt",
        args = { "-w", "$FILENAME" },
        -- to_stdin = true,
    },
    factory = h.formatter_factory,
})

-- h.make_builtin({
--   name = "dartfmt",
--   method = FORMATTING,
--   filetypes = { "dart" },
--   generator_opts = {
--       command = "dart",
--       args = { "-format", "$FILENAME" },
--       -- to_stdin = true,
--   },
--   factory = h.formatter_factory,
-- })

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  formatting.prettier.with({
    extra_filetypes = { "svelte" },
  }),
  formatting.stylua,
  formatting.black,
  formatting.clang_format,
  formatting.gofmt,
  formatting.dart_format,

  lint.shellcheck,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
