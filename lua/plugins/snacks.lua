return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true,
          ignored = true,
          exclude = { "**/.git/**", "**/node_modules/**", "**/target/**", "**/build/**", "**/dist/**", "**/.yarn/**" },
        },
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { "**/.git/**", "**/node_modules/**", "**/target/**", "**/.yarn/**" },
        },
        grep = {
          hidden = true,
          ignored = true,
          exclude = { "**/.git/**", "**/node_modules/**", "**/.yarn/**" },
        },
      },
    },
  },
}
