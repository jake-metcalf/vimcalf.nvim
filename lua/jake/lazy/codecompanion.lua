return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        adapters = {
            http = {
                openai = function()
                    return require("codecompanion.adapters").extend("openai", {
                        env = {
                            api_key = os.getenv "OPENAI_API_KEY_ASX",
                        },
                        schema = {
                            model = {
                                default = "gpt-4o",
                            },
                        },
                    })
                end,
            },
        },
        strategies = {
            chat = {
                adapter = "openai",
                tools = {
                    ["mcp"] = {
                        -- calling it in a function would prevent mcphub from being loaded before it's needed
                        callback = function()
                            return require "mcphub.extensions.codecompanion"
                        end,
                        description = "Call tools and resources from the MCP Servers",
                        opts = {
                            requires_approval = true,
                        },
                    },
                },
            },
        },
        display = {
            diff = {
                enabled = true,
                close_chat_at = 240,
                layout = "vertical",
                opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
                provider = "default",
            },
        },
    },
}
