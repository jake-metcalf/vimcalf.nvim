vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Allow Wq as wq
vim.api.nvim_create_user_command("Wq", "wq", {})

-- Cancel highlighted area
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Jump forward
vim.keymap.set("n", "<leader><Tab>", "<C-i>", { desc = "Jump forward" })

-- Redo with <C-y> (replaces default scroll-up-one-line)
vim.keymap.set("n", "<C-y>", "<C-r>", { desc = "Redo" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Navigate buffers more easily
vim.keymap.set({ "n", "v" }, "<leader>bn", "<cmd>bn<CR>", { desc = "Next buffer" })
vim.keymap.set({ "n", "v" }, "<leader>bp", "<cmd>bp<CR>", { desc = "Previous buffer" })

-- Shift lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Improved movement
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "G", "Gzz")

-- Paste and Yank enhancements
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over selected text" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without adding to reg" })
vim.keymap.set({ "n", "v" }, "<leader>yy", ":%y<CR>", { desc = "Yank entire buffer" })
vim.keymap.set("n", "<leader><leader>d", 'gg_"_dG', { desc = "Delete entire buffer" })
vim.keymap.set("n", "<leader><leader>p", 'gg_"_dG_P', { desc = "Replace entire buffer with latest reg" })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "CodeCompanionChat", noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-c>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>ca", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
vim.cmd [[cab cc CodeCompanion]]

-- Python debugger shortcut
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.keymap.set("n", "<leader>mm", "oimport ipdb; ipdb.set_trace()<Esc>", { buffer = true, desc = "Insert ipdb breakpoint" })
    end,
})
