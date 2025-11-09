return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  opts = {
    detection_methods = { "pattern" },
    patterns = { "pyproject.toml", ".git" },
    silent_chdir = false,
    manual_mode = false,
  },
  config = function(_, opts)
    ---------------------------------------------------------------------------
    -- 1. Setup project.nvim
    ---------------------------------------------------------------------------
    require("project_nvim").setup(opts)

    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        local ok, project = pcall(require, "project_nvim.project")
        if not ok or not project.get_project_root then
          return
        end
        local path = project.get_project_root()
        if path and path ~= vim.fn.getcwd() then
          vim.cmd("cd " .. path)
        end
      end,
      desc = "Auto change directory to project root",
    })

    ---------------------------------------------------------------------------
    -- 2. Restart LSP automatically after cwd changes
    ---------------------------------------------------------------------------
    vim.api.nvim_create_autocmd("DirChanged", {
      callback = function()
        vim.schedule(function()
          local bufnr = vim.api.nvim_get_current_buf()
          local clients = vim.lsp.get_clients({ bufnr = bufnr })
          if #clients == 0 then
            vim.cmd("edit") -- triggers LSP attach
          else
            -- optional: restart all python LSP clients if cwd changes
            for _, c in ipairs(clients) do
              if vim.tbl_contains({ "basedpyright", "pyright", "pylsp" }, c.name) then
                c.stop()
              end
            end
            vim.defer_fn(function()
              vim.cmd("edit")
            end, 200)
          end
        end)
      end,
      desc = "Restart LSP when project.nvim changes working directory",
    })

    ---------------------------------------------------------------------------
    -- 3. Auto-detect Poetry or venv virtualenv for Python LSP
    ---------------------------------------------------------------------------
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
          return
        end

        if vim.tbl_contains({ "basedpyright", "pyright", "pylsp" }, client.name) then
          -- try Poetry first
          local poetry_env = vim.fn.system("poetry env info -p"):gsub("%s+", "")
          if vim.v.shell_error ~= 0 or poetry_env == "" then
            -- fallback to local .venv or venv directory
            if vim.fn.isdirectory(".venv") == 1 then
              poetry_env = vim.fn.getcwd() .. "/.venv"
            elseif vim.fn.isdirectory("venv") == 1 then
              poetry_env = vim.fn.getcwd() .. "/venv"
            else
              poetry_env = ""
            end
          end

          if poetry_env ~= "" then
            local python_path = poetry_env .. "/bin/python"
            client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, {
              python = { pythonPath = python_path },
            })
            vim.notify("Using Python env: " .. python_path, vim.log.levels.INFO)
          else
            vim.notify("No Poetry or venv detected for this project", vim.log.levels.WARN)
          end
        end
      end,
      desc = "Auto-detect and use Poetry/venv for Python LSP",
    })
  end,
}

