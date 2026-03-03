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
        overrides = function(colors)
          return {
            Visual = { bg = colors.palette.waveBlue2, fg = colors.theme.ui.fg },
          }
        end,
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
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
    provider = "custom",
    custom = {
      endpoint = "http://localhost:11434/api/generate",
      model = "qwen-coder",
      request = function(prompt)
        return {
          model = "qwen-coder",
          prompt = prompt,
          stream = false,
        }
      end,
      parse_response = function(body) return body.response end,
    },
  },
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },

    keys = {
      { "<leader>o", "", desc = "Opencode AI" },

      {
        "<leader>oo",
        function() require("opencode").ask("@this: ", { submit = true }) end,
        mode = { "n", "x" },
        desc = "Ask opencode…",
      },
      {
        "<leader>os",
        function() require("opencode").select() end,
        mode = { "n", "x" },
        desc = "Select / Execute action…",
      },

      {
        "<leader>or",
        function() return require("opencode").operator "@this " end,
        mode = "n",
        expr = true,
        desc = "Range → opencode",
      },
      {
        "<leader>ol",
        function() return require("opencode").operator "@this " .. "_" end,
        mode = "n",
        expr = true,
        desc = "Line → opencode",
      },

      {
        "<leader>ot",
        function() require("opencode").toggle() end,
        mode = { "n", "t" },
        desc = "Toggle opencode window",
      },
      {
        "<leader>ou",
        function() require("opencode").command "session.half.page.up" end,
        desc = "Scroll opencode ↑ half page",
      },
      {
        "<leader>od",
        function() require("opencode").command "session.half.page.down" end,
        desc = "Scroll opencode ↓ half page",
      },
    },

    config = function()
      vim.g.opencode_opts = {
        server = {
          autostart = false,
          host = "192.168.88.137",
          port = 42420,
          url = "http://192.168.88.137:8000/v1",
        },

        ui = false,
        events = {
          reload = true,
        },
      }
      vim.o.autoread = true
    end,
  },
}
