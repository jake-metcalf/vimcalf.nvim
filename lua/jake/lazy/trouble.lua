return {
    {
        "folke/trouble.nvim",
        opts = { -- for default options, refer to the configuration section for custom setup.
            win = { type = "split", position = "right", size = 0.4 },
        },
        cmd = "Trouble",
        keys = {
            {
                "<leader>ld",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>lD",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
        },
    },
}
