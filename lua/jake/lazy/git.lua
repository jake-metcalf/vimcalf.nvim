return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require "gitsigns"

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation between hunks
                map("n", "]h", gitsigns.next_hunk, { desc = "Next hunk" })
                map("n", "[h", gitsigns.prev_hunk, { desc = "Previous hunk" })

                -- Staging/unstaging (normal mode)
                map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
                map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
                map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })

                -- Staging/unstaging (visual mode for partial hunks)
                map("v", "<leader>hs", function()
                    gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
                end, { desc = "Stage selected lines" })
                map("v", "<leader>hr", function()
                    gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
                end, { desc = "Reset selected lines" })

                -- Buffer-level operations
                map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
                map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })

                -- Preview and blame
                map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
                map("n", "<leader>hb", gitsigns.blame_line, { desc = "Blame line" })

                -- Toggle deleted lines visibility
                map("n", "<leader>hd", gitsigns.toggle_deleted, { desc = "Toggle deleted" })
            end,
        },
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - Diff integration
            "echasnovski/mini.pick", -- optional
        },
        config = function()
            local neogit = require "neogit"
            neogit.setup {
                integrations = { diffview = true },
                graph_style = "unicode",
                signs = {
                    hunk = { "", "" },
                    item = { ">", "v" },
                    section = { ">", "v" },
                },
            }
            vim.keymap.set("n", "<leader>gs", neogit.open, { noremap = true, silent = true, desc = "Neogit" })
        end,
    },
    {
        "sindrets/diffview.nvim",
        config = function()
            require("diffview").setup {
                enhanced_diff_hl = true,
            }

            local function get_default_branch_name()
                local res = vim.system({ "git", "rev-parse", "--verify", "main" }, { capture_output = true }):wait()
                return res.code == 0 and "main" or "master"
            end

            -- Diff against local master branch
            vim.keymap.set("n", "<leader>hm", function()
                vim.cmd("DiffviewOpen " .. get_default_branch_name())
            end, { desc = "Diff against master" })

            -- Diff against remote master branch
            vim.keymap.set("n", "<leader>hM", function()
                vim.cmd("DiffviewOpen HEAD..origin/" .. get_default_branch_name())
            end, { desc = "Diff against origin/master" })

            vim.keymap.set("n", "<leader>hh", "<cmd>DiffviewFileHistory<cr>", { desc = "Repo history" })
            vim.keymap.set("n", "<leader>hf", "<cmd>DiffviewFileHistory --follow %<cr>", { desc = "File history" })
            vim.keymap.set("v", "<leader>hl", "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", { desc = "Range history" })
            vim.keymap.set("n", "<leader>ho", "<cmd>DiffviewOpen<cr>", { desc = "Repo diff" })
        end,
    },
}
