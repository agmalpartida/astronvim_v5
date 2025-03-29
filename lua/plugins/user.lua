--if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==


  "max397574/better-escape.nvim",
  {
  cond = not vim.g.vscode,
  opts = function(_, opts)
    local esc_fn = function()
      if vim.bo.filetype == "OverseerForm" then
        return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<Esc>lx" or "<Esc>x"
      end
      return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<Esc>l" or "<Esc>"
    end
    opts.mappings = {
      i = {
        j = {
          k = esc_fn,
        },
        k = {
          j = esc_fn,
        },
      },
      c = {
        j = {
          k = esc_fn,
        },
        k = {
          j = esc_fn,
        },
      },
      t = {
        j = {
          k = "<C-\\><C-n>",
        },
        k = {
          j = esc_fn,
        },
      },
      v = {},
      x = {},
      s = {},
    }
  end
},

  "HakonHarnes/img-clip.nvim",
  {
  opts = function(_, opts)
    opts.default = {
      -- file and directory options
      dir_path = "assets",
      -- dir_path = function()
      --   return vim.fn.expand("%:t:r")
      -- end,
      extension = "png",
      -- file_name = "%Y-%m-%d-%H-%M-%S",
      file_name = function()
        local filename = vim.fn.expand("%:t:r") -- file_name with no extension
        local date = os.date("%Y-%m-%d_%H-%M-%S") -- datetime
        return filename .. "_" .. date -- format: filename_YYYY-MM-DD_HH-MM-SS
      end,
      notify = true,
      use_absolute_path = false,
      relative_to_current_file = true,
      -- prompt options
      prompt_for_file_name = false,
    }
  end
  },


    "L3MON4D3/LuaSnip",
  {
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end)
      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if luasnip.choice_active() then
       luasnip.change_choice(-1)
       end
      end)
      luasnip.filetype_extend("javascript", { "javascriptreact" })
      -- load snippets paths
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { vim.fn.stdpath "config" .. "/snippets" },
      }
    end,
  },


    "nvim-neo-tree/neo-tree.nvim",
  {
    opts = {
      --window = 40,
      default_component_configs = {
        container = {
          enable_character_fade = false,
        },
        -- file_size = {
        --   enabled = true,
        --   required_width = 24, -- min width of window required to show this column
        -- },
        -- type = {
        --   enabled = true,
        --   required_width = 122, -- min width of window required to show this column
        -- },
        -- last_modified = {
        --   enabled = true,
        --   required_width = 88, -- min width of window required to show this column
        -- },
        -- created = {
        --   enabled = true,
        --   required_width = 110, -- min width of window required to show this column
        -- },
        -- symlink_target = {
        --   enabled = false,
        -- },
      },
      window = {
          position = "left",
          width = 30,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignore = false,
          hide_by_name = {
            ".DS_Store",
            "thumbs.db",
            "node_modules",
            "__pycache__",
          },
        },
      },
    },
  },


    "windwp/nvim-autopairs",
  {
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  "kylechui/nvim-surround",
  {
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  opts = {
    aliases = {
      ["b"] = { ")", "}", "]", ">" },
    },
  },
  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  },


 "goolord/alpha-nvim",
  {
    plugins = {
      telescope = {
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      },
    },
  },


  "folke/which-key.nvim",
  {
  opts = {
    preset = "modern",
    delay = 0,
    icons = {
      separator = "➜",
    },
  },
  },
  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
