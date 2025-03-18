return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
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
            vim.keymap.set("n", "<leader>gs", neogit.open, { noremap = true, silent = true, desc = "Neogit" })
        end,
    },
    {
        "sindrets/diffview.nvim",
        config = function()
            require("diffview").setup()

            local function get_default_branch_name()
                local res = vim.system({ "git", "rev-parse", "--verify", "main" }, { capture_output = true }):wait()
                return res.code == 0 and "main" or "master"
            end

            vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk, { desc = "Preview hunk" })

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
