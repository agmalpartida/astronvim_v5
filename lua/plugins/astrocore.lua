-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      -- disable alpha autostart
      alpha_autostart = false,
      temporary_files = {
        {
          -- event is added here as a string or a list-like table of events
          event = { "BufNewFile", "BufRead" },
          pattern = "Jenkinsfile*",
          command = "set filetype=groovy",
        },
      },
      -- git_branch_sessions = {
      --   -- auto save directory sessions on leaving
      --   {
      --     event = "VimLeavePre",
      --     desc = "Save git branch directory sessions on close",
      --     callback = vim.schedule_wrap(function()
      --       if require("astrocore.buffer").is_valid_session() then
      --         require("resession").save(get_session_name(), { dir = "dirsession", notify = false })
      --       end
      --     end),
      --   },
      --   -- auto restore previous previous directory session, remove if necessary
      --   {
      --     event = "VimEnter",
      --     desc = "Restore previous directory session if neovim opened with no arguments",
      --     nested = true, -- trigger other autocommands as buffers open
      --     callback = function()
      --       -- Only load the session if nvim was started with no args
      --       if vim.fn.argc(-1) == 0 then
      --         -- try to load a directory session using the current working directory
      --         require("resession").load(get_session_name(), { dir = "dirsession", silence_errors = true })
      --       end
      --     end,
      --   },
      -- },
      restore_session = {
        {
          event = "VimEnter",
          desc = "Restore previous directory session if neovim opened with no arguments",
          nested = true, -- trigger other autocommands as buffers open
          callback = function()
            -- Only load the session if nvim was started with no args
            if vim.fn.argc(-1) == 0 then
              -- try to load a directory session using the current working directory
              require("resession").load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
            end
          end,
        },
      },
      -- autohidetabline = {
      --   -- each augroup contains a list of auto commands
      --   {
      --     -- create a new autocmd on the "User" event
      --     event = "User",
      --     -- the pattern is the name of our User autocommand events
      --     pattern = "AstroBufsUpdated", -- triggered when vim.t.bufs is updated
      --     -- nice description
      --     desc = "Hide tabline when only one buffer and one tab",
      --     -- add the autocmd to the newly created augroup
      --     group = "autohidetabline",
      --     callback = function()
      --       -- if there is more than one buffer in the tab, show the tabline
      --       -- if there are 0 or 1 buffers in the tab, only show the tabline if there is more than one vim tab
      --       local new_showtabline = #vim.t.bufs > 1 and 2 or 1
      --       -- check if the new value is the same as the current value
      --       if new_showtabline ~= vim.opt.showtabline:get() then
      --         -- if it is different, then set the new `showtabline` value
      --         vim.opt.showtabline = new_showtabline
      --       end
      --     end,
      --   },
      --},
    },
    rooter = {
      -- list of detectors in order of prevalence, elements can be:
      --   "lsp" : lsp detection
      --   string[] : a list of directory patterns to look for
      --   fun(bufnr: integer): string|string[] : a function that takes a buffer number and outputs detected roots
      detector = {
        "lsp", -- highest priority is getting workspace from running language servers
        { ".git", "_darcs", ".hg", ".bzr", ".svn" }, -- next check for a version controlled parent directory
        { "lua", "MakeFile", "package.json" }, -- lastly check for known project root files
      },
      -- ignore things from root detection
      ignore = {
        servers = {}, -- list of language server names to ignore (Ex. { "efm" })
        dirs = {}, -- list of directory patterns (Ex. { "~/.cargo/*" })
      },
      -- automatically update working directory (update manually with `:AstroRoot`)
      autochdir = true,
      -- scope of working directory to change ("global"|"tab"|"win")
      scope = "global",
      -- show notification on every working directory change
      notify = false,
    },
    sessions = {
      -- Configure auto saving
      autosave = {
        last = true, -- auto save last session
        cwd = true, -- auto save session for each working directory
      },
      mappings = {
        n = {
          -- update save dirsession mapping to get the correct session name
          ["<Leader>SS"] = {
            function() require("resession").save(get_session_name(), { dir = "dirsession" }) end,
            desc = "Save this dirsession",
          },
          -- update load dirsession mapping to get the correct session name
          ["<Leader>S."] = {
            function() require("resession").load(get_session_name(), { dir = "dirsession" }) end,
            desc = "Load current dirsession",
          },
        },
      },
      n = {
        -- update save dirsession mapping to get the correct session name
        ["<Leader>SS"] = {
          function() require("resession").save(get_session_name(), { dir = "dirsession" }) end,
          desc = "Save this dirsession",
        },
        -- update load dirsession mapping to get the correct session name
        ["<Leader>S."] = {
          function() require("resession").load(get_session_name(), { dir = "dirsession" }) end,
          desc = "Load current dirsession",
        },
      },
      -- Patterns to ignore when saving sessions
      ignore = {
        dirs = {}, -- working directories to ignore sessions in
        filetypes = { "gitcommit", "gitrebase", "node_modules" }, -- filetypes to ignore sessions
        buftypes = {}, -- buffer types to ignore sessions
      },
    },
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = true, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        ["<Leader>m"] = { function() vim.cmd "MarkdownPreview" end, desc = "Markdown Preview" },
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["<C-n>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<C-p>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
