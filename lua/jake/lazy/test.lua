return {
    "vim-test/vim-test",
    dependencies = {
        "preservim/vimux",
    },
    vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { desc = "Run nearest test" }),
    vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "Run all tests in file" }),
    vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>", { desc = "Run all tests" }),
    vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { desc = "Run last test" }),
    vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", { desc = "Visit test file" }),
    vim.cmd "let test#strategy = 'vimux'",
}
