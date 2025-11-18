---@type LazySpec
return {
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup {
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = false },
        statementStyle = { bold = true },
        transparent = true, -- do not set background color
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        theme = "wave", -- Load "wave" theme
        background = { -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
      }
    end,
  },
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup {
        filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
      }
    end,
  },

  "kdheepak/lazygit.nvim",
  {
    "stevearc/overseer.nvim",
    opts = {},
  },
  n = {
    ["<leader>to"] = { "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer window" },
    ["<leader>tr"] = { "<cmd>OverseerRun<cr>", desc = "Run task" },
    ["<leader>tl"] = { "<cmd>OverseerRunLast<cr>", desc = "Run last task" },
    ["<leader>tc"] = { "<cmd>OverseerClearCache<cr>", desc = "Clear Overseer cache" },
  },
}
