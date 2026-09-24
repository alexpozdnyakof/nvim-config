return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"

      dap.adapters["pwa-chrome"] = function(cb, config)
        local port = 8123
        vim.fn.jobstart {
          "node",
          vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
          tostring(port),
        }
        vim.defer_fn(
          function()
            cb {
              type = "server",
              host = "::1",
              port = port,
            }
          end,
          500
        )
      end

      for _, lang in ipairs { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" } do
        dap.configurations[lang] = {
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome (Vite)",
            url = "http://localhost:5173",
            webRoot = "${workspaceFolder}/src",
            sourceMaps = true,
            userDataDir = "/tmp/nvim-chrome-debug",
          },
        }
      end
    end,
  },
}
