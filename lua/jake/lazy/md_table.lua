return {
    "Kicamon/markdown-table-mode.nvim",
    config = function()
        require("markdown-table-mode").setup()
        vim.keymap.set("n", "<leader>mt", "<cmd>Mtm<CR>")
    end,
}
