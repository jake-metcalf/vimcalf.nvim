-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- Set conceal level for obsidian
vim.opt.conceallevel = 2

vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Disable mini.git
vim.g.minigit_disable = true

vim.opt.swapfile = false

vim.g.python3_host_prog = "/Users/jake/.pyenv/versions/py3nvim/bin/python"

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("lspattach", {
    desc = "lsp attach and keymaps",
    group = vim.api.nvim_create_augroup("jake", { clear = true }),
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function()
            vim.lsp.buf.definition()
        end, { buffer = e.buf, desc = "go to definition" })
        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover()
        end, { buffer = e.buf, desc = "Buf hover" })
        vim.keymap.set("n", "<leader>lws", function()
            vim.lsp.buf.workspace_symbol()
        end, { buffer = e.buf, desc = "Workspace symbol" })
        vim.keymap.set("n", "<leader>ld", function()
            vim.diagnostic.open_float()
        end, { buffer = e.buf, desc = "Open float" })
        vim.keymap.set("n", "<leader>lca", function()
            vim.lsp.buf.code_action()
        end, { buffer = e.buf, desc = "Code action" })
        vim.keymap.set("n", "<leader>lrr", function()
            vim.lsp.buf.references()
        end, { buffer = e.buf, desc = "References" })
        vim.keymap.set("n", "<leader>lrn", function()
            vim.lsp.buf.rename()
        end, { buffer = e.buf, desc = "Rename" })
        vim.keymap.set("i", "<c-h>", function()
            vim.lsp.buf.signature_help()
        end, { buffer = e.buf, desc = "Signature help" })
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.goto_next()
        end, { buffer = e.buf, desc = "Go to next diagnostic" })
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.goto_prev()
        end, { buffer = e.buf, desc = "Go to previous diagnostic" })
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format { bufnr = args.buf, timeout_ms = 5000 }
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    command = "wincmd L",
})

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--     pattern = "*.md",
--     callback = function()
--         require("lazy").load { spec = "jake.lazy.obsidian", plugins = {} }
--     end,
-- })

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local obsidian = require "jake.lazy.obsidian"
        if string.find(vim.fn.expand "%:p", "vaults") then
            vim.notify "we're in!"
            require("lazy").load { spec = "jake.lazy.obsidian", plugins = {} }
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt.spell = true
    end,
})

if vim.fn.argc() == 0 then
    vim.defer_fn(function()
        vim.cmd "lua Snacks.picker.files()"
    end, 0)
end
