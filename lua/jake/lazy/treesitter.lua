local M = {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update { with_sync = true }()
    end,
    opts = {
        ensure_installed = {
            "markdown",
            "markdown_inline",
            "c",
            "lua",
            "vim",
            "vimdoc",
            "typescript",
            "tsx",
            "javascript",
            "html",
            "css",
            "svelte",
            "terraform",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
    },
}

return { M }
