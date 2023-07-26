local m = { noremap = true, nowait = true }
local M = {}

M.config = {
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        keys = {
            { "<leader>ff", "<cmd>Telescope<cr>", desc = "Telescope" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "LukasPietzschmann/telescope-tabs",
                config = function()
                    local tstabs = require('telescope-tabs')
                    tstabs.setup({
                    })
                    vim.keymap.set('n', '<c-t>', tstabs.list_tabs, {})
                end
            },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            -- "nvim-telescope/telescope-ui-select.nvim",
            'stevearc/dressing.nvim',
            'dimaportenko/telescope-simulators.nvim',
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, m)
            vim.keymap.set('n', '<leader>rs', builtin.resume, m)
            vim.keymap.set('n', '<leader>fb', builtin.buffers, m)
            vim.keymap.set('n', '<leader>fo', builtin.oldfiles, m)
            -- vim.keymap.set('n', '<leader>fu', builtin.current_buffer_fuzzy_find, m)
            vim.keymap.set('n', '<leader>ss', builtin.spell_suggest, m)

            -- vim.keymap.set('n', '<leader>d', builtin.diagnostics, m)
            -- vim.keymap.set('n', 'gd', builtin.lsp_definitions, m)
            -- vim.keymap.set('n', '<c-t>', builtin.lsp_document_symbols, {})
            -- vim.keymap.set('n', 'gi', builtin.git_status, m)
            -- vim.keymap.set("n", ":", builtin.commands, m)

            local trouble = require("trouble.providers.telescope")

            local ts = require('telescope')
            local actions = require('telescope.actions')
            M.ts = ts
            ts.setup({
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--fixed-strings",
                        "--smart-case",
                        "--trim",
                    },
                    layout_config = {
                        width = 0.9,
                        height = 0.9,
                    },
                    mappings = {
                        i = {
                            ["<C-h>"] = "which_key",
                            ["<C-u>"] = "move_selection_previous",
                            ["<C-e>"] = "move_selection_next",
                            ["<C-l>"] = "preview_scrolling_up",
                            ["<C-y>"] = "preview_scrolling_down",
                            ["<esc>"] = "close",
                        }
                    },
                    color_devicons = true,
                    prompt_prefix = "🔍 ",
                    selection_caret = " ",
                    path_display = { "truncate" },
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                },
                pickers = {
                    buffers = {
                        show_all_buffers = true,
                        sort_lastused = true,
                        mappings = {
                            i = {
                                ["<c-d>"] = actions.delete_buffer,
                            },
                        }
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                }
            })
            require('dressing').setup({
                select = {
                    get_config = function(opts)
                        if opts.kind == 'codeaction' then
                            return {
                                backend = 'telescope',
                                telescope = require('telescope.themes').get_cursor()
                            }
                        end
                    end
                }
            })

            ts.load_extension('dap')
            ts.load_extension('telescope-tabs')
            ts.load_extension('fzf')
            ts.load_extension('simulators')

            require("simulators").setup({
                android_emulator = false,
                apple_simulator = true,
            })
            -- ts.load_extension("ui-select")
            local tsdap = ts.extensions.dap;
            vim.keymap.set("n", "<leader>'v", tsdap.variables, m)
            vim.keymap.set("n", "<leader>'a", tsdap.commands, m)
            vim.keymap.set("n", "<leader>'b", tsdap.list_breakpoints, m)
            vim.keymap.set("n", "<leader>'f", tsdap.frames, m)
        end
    },
}


return M
