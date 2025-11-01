return {
  "neanias/everforest-nvim",
  lazy = false, -- o true según prefieras
  config = function()
    require("everforest").setup({
      background = "hard", -- opciones: soft, medium, hard
      transparent_background_level = 0,
      italics = false,
      disable_italic_comments = false,
      sign_column_background = "none",
      ui_contrast = "low",
      dim_inactive_windows = false,
      diagnostic_text_highlight = false,
      diagnostic_virtual_text = "coloured",
      diagnostic_line_highlight = false,
      spell_foreground = false,
      show_eob = true,
      float_style = "bright",
      inlay_hints_background = "none",
    })
    -- vim.cmd([[colorscheme everforest]])
  end,
}
