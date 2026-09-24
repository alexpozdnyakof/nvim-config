---@type LazySpec
return {
  {
    "akinsho/toggleterm.nvim",
    opts = function(_, opts)
      -- Don't remember the last terminal mode: every time a toggleterm window
      -- is shown, start in terminal-mode. This prevents lazygit's floating
      -- overlay from appearing "unfocused" when returning to the terminal.
      opts.persist_mode = false

      local astro_on_create = opts.on_create
      opts.on_create = function(t)
        if astro_on_create then astro_on_create(t) end

        -- Only touch lazygit terminals.
        if type(t.cmd) ~= "string" or not t.cmd:match("lazygit") then return end

        -- Re-enter terminal-mode on keyboard-driven window switches.
        vim.api.nvim_create_autocmd("BufEnter", {
          buffer = t.bufnr,
          callback = function()
            if vim.bo.buftype == "terminal" and vim.fn.mode() ~= "t" then
              vim.schedule(function() vim.cmd("startinsert") end)
            end
          end,
        })

        -- Disable terminal focus-event reporting (CSI ?1004l). Without this,
        -- clicking away from the lazygit float and back can make lazygit
        -- redraw/lose its internal overlay focus, which feels like the window
        -- "lost focus" even though Neovim's focus is in the right place.
        if t.job_id then vim.fn.chansend(t.job_id, "\027[?1004l") end
      end

      -- Also disable focus events each time the terminal becomes visible,
      -- in case the terminal emulator resets the state while hidden.
      local astro_on_open = opts.on_open
      opts.on_open = function(t)
        if astro_on_open then astro_on_open(t) end
        if type(t.cmd) == "string" and t.cmd:match("lazygit") and t.job_id then
          vim.fn.chansend(t.job_id, "\027[?1004l")
        end
      end

      return opts
    end,
  },
}
