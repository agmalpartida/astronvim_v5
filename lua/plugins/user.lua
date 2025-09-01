--if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {


 --  {
 --    "catppuccin/nvim",
 --    name = "catppuccin",
 --    priority = 1000,  -- Carga prioridad alta para que el tema se aplique primero
 --    config = function()
 --      require("catppuccin").setup({
 --        flavour = "mocha",               -- O latte, frappe, macchiato, según prefieras
 --        transparent_background = true,
 --        floating_border = "auto",        -- Opciones válidas: "auto", "on", "off"
 --        integrations = {
 --          leap = true,                   -- Activa integración con leap.nvim
 --          telescope = true,
 --          cmp = true,
 --          gitsigns = true,
 --          -- puedes añadir más integraciones aquí según tus plugins
 --        },
 --      })
 --      vim.cmd.colorscheme("catppuccin") -- Esto debe ir después del setup
 --    end,
 -- },
{
    "rebelot/kanagawa.nvim",
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    -- colors = {                   -- add/modify theme and palette colors
    --     palette = {},
    --     theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    -- },
    -- overrides = function(colors) -- add/modify highlights
    --     return {}
    -- end,
    theme = "wave",              -- Load "wave" theme
    background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
},

 {
  "ggandor/leap.nvim",
  event = "VeryLazy",           -- Carga Leap de forma ligera
  config = function()
    local leap = require("leap")

    -- Mapeos básicos por defecto (s, S)
    leap.set_default_mappings()

    -- Personaliza etiquetas (labels) si quieres cambiar el esquema visual
    leap.opts.labels = "arstneioqwfpluyjhkxvcmgz"  -- Cambia letras de salto

    -- Ejemplo: Hacer que Leap funcione en cualquier ventana abierta (multipanel)
    leap.opts.safe_labels = "arstneio"             -- Etiquetas más "seguras"

    -- Opcional: saltar también en modo visual (útil para seleccionar texto rápido)
    vim.keymap.set("x", "s", function()
      leap.leap { target_windows = { vim.fn.win_getid() } }
    end, { desc = "Leap visual mode" })

    -- Desactiva el auto-salto si prefieres siempre elegir destino
    -- leap.opts.autojump = false

    -- Si quieres permitir equivalencia acentuada (por ejemplo, saltar a 'á' aunque escribas 'a')
    leap.opts.equivalence_classes = { ["aáäâ"] = true, ["eéëê"] = true }

    -- Ejemplo: salta palabras en todas las ventanas abiertas con S
    vim.keymap.set({ "n", "x", "o" }, "S", function()
      leap.leap { target_windows = require("leap.util").get_windows() }
    end, { desc = "Leap to word in all windows" })

    -- Puedes añadir más opciones según la documentación oficial
  end,
},
  
    {
      'sontungexpt/buffer-closer',
      event = "VeryLazy",
      config = function()
        require("buffer-closer").setup({
          min_remaining_buffers = 3,     -- cuántos buffers como mínimo quieres abiertos
          retirement_minutes     = 1,    -- tiempo de inactividad antes de cerrar un buffer (en minutos)
          excluded = {
            -- filetypes = { "lazy", "NvimTree", "mason" },
            -- buftypes = { "terminal", "nofile", "quickfix", "prompt", "help" },
            filenames = { ".*check.md" },             -- puedes añadir nombres concretos a excluir
          },
          ignore_working_windows = true, -- no cerrar buffers que estás viendo
        })
      end,
    },
  

    {
    "max397574/better-escape.nvim",
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
    end,
  },
  
  {
    "HakonHarnes/img-clip.nvim",
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
          local filename = vim.fn.expand "%:t:r" -- file_name with no extension
          local date = os.date "%Y-%m-%d_%H-%M-%S" -- datetime
          return filename .. "_" .. date -- format: filename_YYYY-MM-DD_HH-MM-SS
        end,
        notify = true,
        use_absolute_path = false,
        relative_to_current_file = true,
        -- prompt options
        prompt_for_file_name = false,
      }
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if luasnip.choice_active() then luasnip.change_choice(1) end
      end)
      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if luasnip.choice_active() then luasnip.change_choice(-1) end
      end)
      luasnip.filetype_extend("javascript", { "javascriptreact" })
      -- load snippets paths
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { vim.fn.stdpath "config" .. "/snippets" },
      }
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
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
        symlink_target = {
          enabled = false,
        },
      },
      window = {
        position = "left",
        width = 40,
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
     keys = {
      {
        "<leader>B",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Open buffer view in Neo-tree",
      },
       {
        "<leader>G",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Open Git view in Neo-tree",
       },
     },
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

  {
    "kylechui/nvim-surround",
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

  {
    "goolord/alpha-nvim",
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

  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
      -- delay = 0,
      icons = {
        separator = "➜",
      },
    },
  },


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
}
