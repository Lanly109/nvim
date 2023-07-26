return {
    "instant-markdown/vim-instant-markdown",
	event = "VeryLazy",
    ft = { "markdown" },
    build = "yarn install",
    config = function()
        vim.g.instant_markdown_autostart = 0
        vim.g.instant_markdown_mathjax = 1
    end,
}
