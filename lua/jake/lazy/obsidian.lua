return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    opts = {
        workspaces = {
            {
                name = "default",
                path = "~/vaults/default",
            },
        },

        log_level = vim.log.levels.INFO,

        daily_notes = {
            folder = "notes/dailies",
            date_format = "%Y-%m-%d",
            alias_format = "%B %-d, %Y",
            default_tags = { "daily-notes" },
            template = "todo.md",
        },

        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },

        mappings = {
            -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
            ["<leader>ml"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            -- Toggle check-boxes.
            ["<leader>mc"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true },
            },
            -- Smart action depending on context, either follow link or toggle checkbox.
            ["<cr>"] = {
                action = function()
                    return require("obsidian").util.smart_action()
                end,
                opts = { buffer = true, expr = true },
            },
        },

        new_notes_location = "current_dir",

        -- Optional, customize how note IDs are generated given an optional title.
        ---@param title string|?
        ---@return string
        note_id_func = function(title)
            -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
            -- In this case a note with the title 'My new note' will be given an ID that looks
            -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
            local suffix = ""
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90))
                end
            end
            return tostring(os.time()) .. "-" .. suffix
        end,

        -- Optional, customize how note file names are generated given the ID, target directory, and title.
        ---@param spec { id: string, dir: obsidian.Path, title: string|? }
        ---@return string|obsidian.Path The full path to the new note.
        note_path_func = function(spec)
            -- This is equivalent to the default behavior.
            local path = spec.dir / tostring(spec.id)
            return path:with_suffix ".md"
        end,

        wiki_link_func = function(opts)
            return require("obsidian.util").wiki_link_id_prefix(opts)
        end,

        markdown_link_func = function(opts)
            return require("obsidian.util").markdown_link(opts)
        end,

        preferred_link_style = "wiki",

        disable_frontmatter = false,

        -- Optional, alternatively you can customize the frontmatter data.
        ---@return table
        note_frontmatter_func = function(note)
            -- Add the title of the note as an alias.
            if note.title then
                note:add_alias(note.title)
            end

            local out = { id = note.id, aliases = note.aliases, tags = note.tags }

            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end

            return out
        end,
        templates = {
            folder = "templates",
        },

        -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
        -- URL it will be ignored but you can customize this behavior here.
        ---@param url string
        follow_url_func = function(url)
            -- Open the URL in the default web browser.
            vim.fn.jobstart { "open", url } -- Mac OS
            -- vim.fn.jobstart({"xdg-open", url})  -- linux
            -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
            -- vim.ui.open(url) -- need Neovim 0.10.0+
        end,

        -- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
        -- file it will be ignored but you can customize this behavior here.
        ---@param img string
        follow_img_func = function(img)
            vim.fn.jobstart { "qlmanage", "-p", img } -- Mac OS quick look preview
            -- vim.fn.jobstart({"xdg-open", url})  -- linux
            -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
        end,

        -- Optional, set to true if you use the Obsidian Advanced URI plugin.
        -- https://github.com/Vinzent03/obsidian-advanced-uri
        use_advanced_uri = false,

        -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
        open_app_foreground = false,

        picker = {
            -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
            name = "telescope.nvim",
            -- Optional, configure key mappings for the picker. These are the defaults.
            -- Not all pickers support all mappings.
            note_mappings = {
                -- Create a new note from your query.
                new = "<C-x>",
                -- Insert a link to the selected note.
                insert_link = "<C-l>",
            },
            tag_mappings = {
                -- Add tag(s) to current note.
                tag_note = "<C-x>",
                -- Insert a tag at the current location.
                insert_tag = "<C-l>",
            },
        },

        -- Optional, sort search results by "path", "modified", "accessed", or "created".
        -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
        -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
        sort_by = "modified",
        sort_reversed = true,
        search_max_lines = 1000,
        open_notes_in = "current",

        -- Optional, define your own callbacks to further customize behavior.
        callbacks = {
            -- Runs at the end of `require("obsidian").setup()`.
            ---@param client obsidian.Client
            post_setup = function(client) end,

            -- Runs anytime you enter the buffer for a note.
            ---@param client obsidian.Client
            ---@param note obsidian.Note
            enter_note = function(client, note) end,

            -- Runs anytime you leave the buffer for a note.
            ---@param client obsidian.Client
            ---@param note obsidian.Note
            leave_note = function(client, note) end,

            -- Runs right before writing the buffer for a note.
            ---@param client obsidian.Client
            ---@param note obsidian.Note
            pre_write_note = function(client, note) end,

            -- Runs anytime the workspace is set/changed.
            ---@param client obsidian.Client
            ---@param workspace obsidian.Workspace
            post_set_workspace = function(client, workspace) end,
        },

        ui = {
            enable = true, -- set to false to disable all additional syntax features
            update_debounce = 200, -- update delay after a text change (in milliseconds)
            max_file_length = 5000, -- disable UI features for files with more than this many lines
            checkboxes = {
                -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
                [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                ["x"] = { char = "", hl_group = "ObsidianDone" },
                [">"] = { char = "", hl_group = "ObsidianRightArrow" },
                ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
                ["!"] = { char = "", hl_group = "ObsidianImportant" },
                -- You can also add more custom ones...
            },
            -- Use bullet marks for non-checkbox lists.
            bullets = { char = "•", hl_group = "ObsidianBullet" },
            external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
            reference_text = { hl_group = "ObsidianRefText" },
            highlight_text = { hl_group = "ObsidianHighlightText" },
            tags = { hl_group = "ObsidianTag" },
            block_ids = { hl_group = "ObsidianBlockID" },
            hl_groups = {
                -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
                ObsidianTodo = { bold = true, fg = "#f78c6c" },
                ObsidianDone = { bold = true, fg = "#89ddff" },
                ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
                ObsidianTilde = { bold = true, fg = "#ff5370" },
                ObsidianImportant = { bold = true, fg = "#d73128" },
                ObsidianBullet = { bold = true, fg = "#89ddff" },
                ObsidianRefText = { underline = true, fg = "#c792ea" },
                ObsidianExtLinkIcon = { fg = "#c792ea" },
                ObsidianTag = { italic = true, fg = "#89ddff" },
                ObsidianBlockID = { italic = true, fg = "#89ddff" },
                ObsidianHighlightText = { bg = "#75662e" },
            },
        },

        -- Specify how to handle attachments.
        attachments = {
            -- The default folder to place images in via `:ObsidianPasteImg`.
            -- If this is a relative path it will be interpreted as relative to the vault root.
            -- You can always override this per image by passing a full path to the command instead of just a filename.
            img_folder = "assets/imgs", -- This is the default

            -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
            ---@return string
            img_name_func = function()
                -- prefix image names with timestamp.
                return string.format("%s-", os.time())
            end,

            -- a function that determines the text to insert in the note when pasting an image.
            -- it takes two arguments, the `obsidian.client` and an `obsidian.path` to the image file.
            -- this is the default implementation.
            ---@param client obsidian.client
            ---@param path obsidian.path the absolute path to the image file
            ---@return string
            img_text_func = function(client, path)
                path = client:vault_relative_path(path) or path
                return string.format("![%s](%s)", path.name, path)
            end,
        },
    },
    config = function()
        vim.keymap.set("n", "<leader>mt", ":ObsidianToday<CR>", { desc = "Today's notes" })
        vim.keymap.set("n", "<leader>my", ":ObsidianYesterday<CR>", { desc = "Yesterday's notes" })
        vim.keymap.set("n", "<leader>mf", ":ObsidianTomorrow<CR>", { desc = "Tomorrow's notes" })
    end,
}
