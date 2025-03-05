return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      'echasnovski/mini.pick', -- optional
    },
    config = function()
      local neogit = require 'neogit'
      vim.keymap.set('n', '<leader>gs', neogit.open, { noremap = true, silent = true })
    end,
  },
}
