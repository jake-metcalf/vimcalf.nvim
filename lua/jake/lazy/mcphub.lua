return {
    "ravitemer/mcphub.nvim",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",
    config = function()
        require("mcphub").setup {
            port = 3000,
            config = vim.fn.expand "~/dev/local/mcp/servers.json",
        }
    end,
}
