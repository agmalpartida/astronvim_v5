-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    -- colorscheme = "astrodark",
    -- colorscheme = "catppuccin",
    -- colorscheme = "gruvbox-baby",
    --colorscheme = "kanagawa",
    colorscheme = "everforest",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
      },
      astrodark = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
    },
    -- Configure which icons that are highlighted based on context
    icon_highlights = {
      -- enable or disable breadcrumb icon highlighting
      breadcrumbs = false,
      -- Enable or disable the highlighting of filetype icons both in the statusline and tabline
      file_icon = {
        tabline = function(self) return self.is_active or self.is_visible end,
        statusline = true,
      },
    },
    -- Configure characters used as separators for various elements
    separators = {
      none = { "", "" },
      left = { "", "  " },
      right = { "  ", "" },
      center = { "  ", "  " },
      tab = { "", "" },
      breadcrumbs = "  ",
      path = "  ",
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
     -- Configure enabling/disabling of winbar
    winbar = {
      enabled = { -- whitelist buffer patterns
        filetype = { "gitsigns.blame" },
      },
      disabled = { -- blacklist buffer patterns
        buftype = { "nofile", "terminal" },
      },
    },
  },
   -- Configure theming of Lazygit, set to `false` to disable
  lazygit = {
    theme_path = vim.fs.normalize(vim.fn.stdpath "cache" .. "/lazygit-theme.yml"),
    theme = {
      [241] = { fg = "Special" },
      activeBorderColor = { fg = "MatchParen", bold = true },
      cherryPickedCommitBgColor = { fg = "Identifier" },
      cherryPickedCommitFgColor = { fg = "Function" },
      defaultFgColor = { fg = "Normal" },
      inactiveBorderColor = { fg = "FloatBorder" },
      optionsTextColor = { fg = "Function" },
      searchingActiveBorderColor = { fg = "MatchParen", bold = true },
      selectedLineBgColor = { bg = "Visual" },
      unstagedChangesColor = { fg = "DiagnosticError" },
    },
  },
  -- {
  --   "sainnhe/sonokai",
  --   init = function() -- init function runs before the plugin is loaded
  --     vim.g.sonokai_style = "shusia"
  --   end,
  -- },
}
