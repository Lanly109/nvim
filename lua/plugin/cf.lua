local function run_command(command)
    vim.cmd("w")
    vim.cmd("sp")
	vim.cmd("res -5")
    vim.cmd("term " .. command)
end

local function cf_test()
    run_command("cf test")
end

local function cf_submit()
    run_command("cf submit")
end

vim.keymap.set('n', 'ss', cf_submit, { silent = true })
vim.keymap.set('n', 'sc', cf_test, { silent = true })
