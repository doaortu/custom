local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

-- local on_attach = function(client, bufnr)
-- configs.on_attach(client, bufnr)
-- if client.server_capabilities.inlayHintProvider then
-- vim.lsp.inlay_hint.enable(true)
-- vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#A6A6A6", bg = "#454545" })
-- end
-- end

local lspconfig = require "lspconfig"
local util = require("lspconfig.util")

-- Function to read the .nvim-lsp.json file and return the disabled servers list
local function get_disabled_servers()
  local cwd = vim.fn.getcwd()

  local lsp_config_path = cwd .. "/.nvim/lsp.json"
  local disabled_servers = {}

  if vim.fn.filereadable(lsp_config_path) == 1 then
    local file = io.open(lsp_config_path, "r")
    if file then
      local content = file:read("*a")
      file:close()
      local noErr, parsed = pcall(vim.json.decode, content)
      if noErr and parsed and parsed.forceDisable then
        disabled_servers = parsed.forceDisable
      end
    end
  end
  return disabled_servers
end

-- Get the list of disabled servers
local disabled_servers = get_disabled_servers()

local function isServerDisabled(server)
  return vim.tbl_contains(disabled_servers, server)
end

require('mason-lspconfig').setup_handlers({
  function(server)
    if isServerDisabled(server) then
      return
    end
    lspconfig[server].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
  ['lua_ls'] = function()
    if isServerDisabled('lua_ls') then
      return
    end
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          hint = { enable = true }
        }
      }
    })
  end,
  ['gopls'] = function()
    if isServerDisabled('gopls') then
      return
    end
    lspconfig.gopls.setup({
      settings = {
        gopls = {
          ["ui.inlayhint.hints"] = {
            compositeLiteralFields = true,
            constantValues = true,
            parameterNames = true
          },
        },
      },
    })
  end,
  ['tsserver'] = function()
    if isServerDisabled('tsserver') then
      return
    end
    lspconfig.tsserver.setup({
      settings = {
        typescript = {
          -- inlayHints = {
          --   includeInlayParameterNameHints = 'all',
          --   includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          --   includeInlayFunctionParameterTypeHints = true,
          --   includeInlayVariableTypeHints = true,
          --   includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          --   includeInlayPropertyDeclarationTypeHints = true,
          --   includeInlayFunctionLikeReturnTypeHints = true,
          --   includeInlayEnumMemberValueHints = true,
          -- }
        },
        javascript = {
          -- inlayHints = {
          --   includeInlayParameterNameHints = 'all',
          --   includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          --   includeInlayFunctionParameterTypeHints = true,
          --   includeInlayVariableTypeHints = true,
          --   includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          --   includeInlayPropertyDeclarationTypeHints = true,
          --   includeInlayFunctionLikeReturnTypeHints = true,
          --   includeInlayEnumMemberValueHints = true,
          -- }
        },
        completions = { completeFunctionCalls = true }
      }
    })
  end,
  ['zls'] = function()
    if isServerDisabled('zls') then
      return
    end
    lspconfig.zls.setup({
      cmd = { "/media/candra/SSD_EXT/LinuxApp/code_env/zig_0.12_dev/zls" },
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
  ['pyright'] = function()
    if isServerDisabled('pyright') then
      return
    end
    lspconfig.pyright.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        pyright = {
          autoImportCompletions = true,
        },
        python = {
          analysis = {
            -- autoSearchPaths = true,
            -- diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
          }
        }
      }
    })
  end
})

if not isServerDisabled('sourcekit') then
  lspconfig.sourcekit.setup({
    cmd = { "sourcekit-lsp" },
    root_dir = util.root_pattern("buildServer.json", "*.xcodeproj", "*.xcworkspace", "Package.swift"),
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
if not isServerDisabled('dartls') then
  lspconfig.dartls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { 'dart', 'language-server', '--protocol=lsp' },
    filetypes = { 'dart' },
    root_dir = util.root_pattern 'pubspec.yaml',
    init_options = {
      onlyAnalyzeProjectsWithOpenFiles = true,
      suggestFromUnimportedLibraries = true,
      closingLabels = true,
      outline = true,
      flutterOutline = true,
    },
    settings = {
      dart = {
        completeFunctionCalls = true,
        showTodos = true,
      },
    }
  });
end
