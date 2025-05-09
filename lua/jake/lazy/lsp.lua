return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        { "mason-org/mason.nvim", version = "1.11.0" },
        { "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    { path = "snacks.nvim", words = { "Snacks" } },
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },

    config = function()
        require("conform").setup {
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettier", stop_after_first = true },
                typescript = { "prettier", stop_after_first = true },
                python = function(bufnr)
                    if require("conform").get_formatter_info("ruff_format", bufnr).available then
                        return { "ruff_format", "isort" }
                    else
                        return { "isort", "black" }
                    end
                end,
                typescriptreact = { "prettier", stop_after_first = true },
                go = { "goimports", "gofmt" },
                terraform = { "terraform_fmt" },
            },
        }
        local cmp = require "cmp"
        local cmp_lsp = require "cmp_nvim_lsp"
        local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())
        local lspconfig = require "lspconfig"
        require("fidget").setup {}
        require("mason").setup()
        require("mason-lspconfig").setup {
            ensure_installed = {
                "basedpyright",
                "lua_ls",
                "ts_ls",
                "marksman",
                "gopls",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                    }
                end,

                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                },
                            },
                        },
                    }
                end,
                ["ts_ls"] = function()
                    lspconfig.ts_ls.setup {
                        capabilities = capabilities,
                        filetypes = {
                            "typescript",
                            "typescriptreact",
                            "typescript.tsx",
                        },
                    }
                end,
                ["basedpyright"] = function()
                    lspconfig["basedpyright"].setup {
                        capabilities = capabilities,
                        settings = {
                            basedpyright = {
                                analysis = {
                                    typeCheckingMode = "basic",
                                },
                            },
                        },
                    }
                end,
                ["gopls"] = function()
                    lspconfig["gopls"].setup {
                        capabilities = capabilities,
                        settings = {
                            gopls = {
                                experimentalPostfixCompletions = true,
                                analyses = {
                                    unusedparams = true,
                                    shadow = true,
                                    fieldalignment = true,
                                },
                                staticcheck = true,
                            },
                        },
                    }
                end,
            },
            automatic_installation = true,
        }

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup {
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert {
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-b>"] = cmp.mapping.confirm { select = true },
                ["<C-Space>"] = cmp.mapping.complete(),
            },
            sources = cmp.config.sources({
                { name = "codecompanion" },
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- For luasnip users.
            }, {
                { name = "buffer" },
            }),
        }

        vim.diagnostic.config {
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
        }
    end,
}
