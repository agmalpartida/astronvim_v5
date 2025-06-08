-- Blink.nvim is a Neovim plugin that provides an AI-powered completion engine.
-- https://cmp.saghen.dev/
return {
  "Saghen/blink.cmp",
  optional = true,
  opts = function(_, opts)
    if not opts.keymap then
      opts.keymap = {}
    end
    opts.keymap["<Tab>"] = {
      "snippet_forward",
      function()
        if vim.g.ai_accept then
          return vim.g.ai_accept()
        end
      end,
      "fallback",
    }
    opts.keymap["<S-Tab>"] = { "snippet_backward", "fallback" }
    opts.sources = {
      providers = {
        path = { score_offset = 3 },
        lsp = { score_offset = 0 },
        snippets = { score_offset = -1 },
        buffer = { score_offset = -3 },
      },
    }
  end,
}

