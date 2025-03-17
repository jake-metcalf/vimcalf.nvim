return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
    config = function()
        local oil = require "oil"

        oil.setup {}

        _G.fuzzy_oil = function()
            local find_command = {
                "fd",
                "--type",
                "d",
                "--color",
                "never",
            }

            vim.fn.jobstart(find_command, {
                stdout_buffered = true,
                on_stdout = function(_, data)
                    if data then
                        local filtered = vim.tbl_filter(function(el)
                            return el ~= ""
                        end, data)

                        local items = {}
                        for _, v in ipairs(filtered) do
                            table.insert(items, { text = v })
                        end

                        ---@module 'snacks'
                        Snacks.picker.pick {
                            source = "directories",
                            items = items,
                            layout = { preset = "select" },
                            format = "text",
                            confirm = function(picker, item)
                                picker:close()
                                vim.cmd("Oil " .. item.text)
                            end,
                        }
                    end
                end,
            })
        end

        vim.keymap.set("n", "<leader>fd", _G.fuzzy_oil, { desc = "Fuzzy find directories with Oil" })
    end,
}
