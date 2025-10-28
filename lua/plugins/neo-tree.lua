return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 40,
      position = "right",
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
  },
}
