return {
    "nvim-treesitter/playground",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "typescript", "java", "c", "bash", "go", "lua", "html", "vim", "cpp", "python" },
                highlight = {
                    enable = true,
                    disable = {}, -- list of language that will be disabled
                },
                indent = {
                    enable = false
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection    = "<CR>",
                        node_incremental  = "<CR>",
                        node_decremental  = "<BS>",
                        scope_incremental = "<TAB>",
                    },
                }
            })
        end
    },
}
