return {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
        { "williamboman/mason.nvim", build = ":MasonUpdate", },
    },
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })
        local lspconfig = require("lspconfig")
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "clangd",
                "gopls",
                "pyright",
                "cssls",
                "html",
                "quick_lint_js",
                "ltex",
            },
            automatic_installation = true,
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        }
                    }
                end,
                ["clangd"] = function()
                    lspconfig.clangd.setup {
                        cmd = {
                            "clangd",
                            "--header-insertion=never",
                            "--all-scopes-completion",
                            "--completion-style=detailed",
                        }
                    }
                end
            }
        })
    end
}
