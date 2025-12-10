-- return {
--   {
--     "scalameta/nvim-metals",
--     dependencies = { "nvim-lua/plenary.nvim" },
--     ft = { "scala", "sbt" },
--     config = function()
--       local metals = require("metals")
--       local metals_config = metals.bare_config()
--
--       metals_config.settings = {
--         showImplicitArguments = true,
--         showImplicitConversionsAndClasses = true,
--       }
--
--       metals_config.init_options.statusBarProvider = "off"
--
--       -- No cmp_nvim_lsp here — LazyVim manages LSP capabilities itself
--
--       vim.api.nvim_create_autocmd("FileType", {
--         pattern = { "scala", "sbt" },
--         callback = function()
--           metals.initialize_or_attach(metals_config)
--         end,
--       })
--     end,
--   },
-- }
--
-- return {
--   {
--     "scalameta/nvim-metals",
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--       "mfussenegger/nvim-dap", -- make sure dap is installed!
--     },
--     ft = { "scala", "sbt" },
--     config = function()
--       local metals = require("metals")
--       local metals_config = metals.bare_config()
--
--       metals_config.settings = {
--         showImplicitArguments = true,
--         showImplicitConversionsAndClasses = true,
--       }
--
--       metals_config.init_options.statusBarProvider = "off"
--
--       -------------------------------------------------------------------
--       -- 1️⃣ Register Metals' Scala DAP adapter
--       -------------------------------------------------------------------
--       local dap = require("dap")
--       dap.adapters.scala = function(callback, config)
--         callback({
--           type = "server",
--           host = "127.0.0.1",
--           port = config.port,
--         })
--       end
--
--       -------------------------------------------------------------------
--       -- 2️⃣ Attach Metals + enable debugging integration
--       -------------------------------------------------------------------
--       vim.api.nvim_create_autocmd("FileType", {
--         pattern = { "scala", "sbt" },
--         callback = function()
--           metals.initialize_or_attach(metals_config)
--           metals.setup_dap() -- REQUIRED for "run | debug" code lens
--         end,
--       })
--     end,
--   },
-- }


return {
  {
    "scalameta/nvim-metals",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt" },
    config = function()
      local metals = require("metals")
      local metals_config = metals.bare_config()

      metals_config.settings = {
        showImplicitArguments = true,
        showImplicitConversionsAndClasses = true,
      }

      metals_config.init_options.statusBarProvider = "off"

      -------------------------------------------------------------------
      -- REQUIRED: Setup Scala debug adapter (LazyVim does NOT do this)
      -------------------------------------------------------------------
      local dap = require("dap")

      dap.adapters.scala = function(callback, config)
        callback({
          type = "server",
          host = "127.0.0.1",
          port = config.port,
        })
      end

      -- REQUIRED: Debug/run configuration Metals uses for code-lens
      dap.configurations.scala = {
        {
          type = "scala",
          request = "launch",
          name = "RunOrTest",
          metals = {
            runType = "runOrTestFile",
          },
        },
      }

      -------------------------------------------------------------------
      -- Metals attach + debug integration
      -------------------------------------------------------------------
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt" },
        callback = function()
          metals.initialize_or_attach(metals_config)
          metals.setup_dap() -- REQUIRED or code lens will not stay open
        end,
      })
    end,
  },
}

