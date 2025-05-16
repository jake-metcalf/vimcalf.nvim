return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require "harpoon"
        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end)
        vim.keymap.set("n", "<leader>A", function()
            harpoon:list():prepend()
        end)
        vim.keymap.set("n", "<Tab>q", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Open Harpoon" })

        vim.keymap.set("n", "<Tab>y", function()
            harpoon:list():select(1)
        end, { desc = "Harpoon 1" })
        vim.keymap.set("n", "<Tab>u", function()
            harpoon:list():select(2)
        end, { desc = "Harpoon 2" })
        vim.keymap.set("n", "<Tab>i", function()
            harpoon:list():select(3)
        end, { desc = "Harpoon 3" })
        vim.keymap.set("n", "<Tab>o", function()
            harpoon:list():select(4)
        end, { desc = "Harpoon 4" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<Tab>p", function()
            harpoon:list():prev()
        end, { desc = "Previous harpoon" })
        vim.keymap.set("n", "<Tab>n", function()
            harpoon:list():next()
        end, { desc = "Next harpoon" })
    end,
}
