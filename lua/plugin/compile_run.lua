local function compile_run()
    vim.cmd("w")
    local filetype = vim.bo.filetype
    if filetype == 'c' then
        vim.cmd("term gcc % -Wall -o cpp.out && ./cpp.out")
    elseif filetype == 'cpp' then
		vim.cmd("sp")
		vim.cmd("res -5")
		vim.cmd("term g++ -I/Users/lanly/Documents/Code/model/ -std=c++17 % -Wall -o cpp.out && ./cpp.out")
    elseif filetype == 'java' then
        vim.cmd("sp")
        vim.cmd("res -5")
        vim.cmd("term javac % && time java %<")
    elseif filetype == 'sh' then
        vim.cmd("sp")
        vim.cmd("res -5")
        vim.cmd("!time bash %")
    elseif filetype == 'python' then
        vim.cmd("sp")
        vim.cmd("res -5")
        vim.cmd("term python3 %")
    elseif filetype == 'html' then
        vim.cmd("silent! exec '!'" .. g.mkdp_browser .. " % &")
    elseif filetype == 'markdown' then
        vim.cmd("InstantMarkdownPreview")
    elseif filetype == 'javascript' then
        vim.cmd("sp")
        vim.cmd("res -5")
        vim.cmd("term export DEBUG=\"INFO,ERROR,WARNING\"; node --trace-warnings .")
    elseif filetype == 'go' then
        vim.cmd("sp")
        vim.cmd("res -5")
        vim.cmd("term go run .")
    elseif filetype == 'dot' then
        vim.cmd("sp")
        vim.cmd("term dot -Tpng -o %:r.png % && open %:r.png")
    end
end

vim.keymap.set('n', 'R', compile_run, { silent = true })
