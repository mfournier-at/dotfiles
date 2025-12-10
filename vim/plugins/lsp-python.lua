return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      opts.servers = opts.servers or {}

      -------------------------------------------------------------------
      -- Safe root_dir: handles invalid fname values (0, nil, "")
      -------------------------------------------------------------------
      local function safe_root_dir(fname)
        -- When triggered by certain autocommands, fname can be a number or nil.
        if type(fname) ~= "string" or fname == "" then
          fname = vim.api.nvim_buf_get_name(0)
        end
        if type(fname) ~= "string" or fname == "" then
          return nil
        end

        -- Prefer folder with pyproject.toml
        local root = util.root_pattern("pyproject.toml")(fname)
        if root then
          return root
        end

        -- Otherwise fallback to git ancestor
        return util.find_git_ancestor(fname)
      end

      -------------------------------------------------------------------
      -- Python interpreter detection logic (unchanged)
      -------------------------------------------------------------------
      local function detect_python(root_dir)
        -- 1) Prefer project-local .venv
        local venv_python = root_dir .. "/.venv/bin/python"
        if vim.fn.executable(venv_python) == 1 then
          return venv_python
        end

        -- 2) Try poetry-managed env
        local cmd = "cd " .. root_dir .. " && poetry env info --path 2>/dev/null"
        local handle = io.popen(cmd)
        if handle then
          local env_path = handle:read("*l")
          handle:close()
          if env_path and env_path ~= "" then
            local poetry_python = env_path .. "/bin/python"
            if vim.fn.executable(poetry_python) == 1 then
              return poetry_python
            end
          end
        end

        -- 3) Fallback to Pyright auto-detection
        return nil
      end

      -------------------------------------------------------------------
      -- Pyright server config
      -------------------------------------------------------------------
      opts.servers.pyright = vim.tbl_deep_extend("force", opts.servers.pyright or {}, {
        root_dir = safe_root_dir,

        on_new_config = function(config, root_dir)
          config.settings = config.settings or {}
          config.settings.python = config.settings.python or {}

          local python = detect_python(root_dir)
          if python then
            config.settings.python.pythonPath = python
          end
        end,
      })

      -- Force registration so our overrides apply even with LazyVim defaults
      lspconfig.pyright.setup(opts.servers.pyright)
    end,
  },
}

