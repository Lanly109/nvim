local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.XkbSwitchEnabled = 1
vim.g.UltiSnipsSnippetDirectories = { "customer/mysnippets" }

require("lazy").setup({
    require("config.plugins.comment"),
    require("config.plugins.colorscheme"),
    require("config.plugins.fm"),
    -- require("config.plugins.dropbar"),
    require("config.plugins.telescope").config,
    require("config.plugins.autocomplete").config,
    require("config.plugins.debugger"),
    require("config.plugins.treesitter"),
    require("config.plugins.wilder"),
    require("config.plugins.tabline"),
    require("config.plugins.mason"),
    require("config.plugins.lspconfig").config,
    require("config.plugins.go"),
    require("config.plugins.markdown"),
    require("config.plugins.xkbswitch"),
}, {
})

require("plugin.compile_run")
require("plugin.cf")

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = { "*" },
    callback = function()
        vim.highlight.on_yank({
            timeout = 300,
        })
    end,
})
