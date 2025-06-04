return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astroui.status")
    opts.statusline = { -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode({
        mode_text = { padding = { left = 1, right = 1 } },
      }), -- add the mode text
      status.component.git_branch(),
      status.component.file_info(),
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.virtual_env(),
      status.component.treesitter(),
      status.component.nav(),
      -- remove the 2nd mode indicator on the right
      -- Create a custom component to display the time
      status.component.builder({
        {
          provider = function()
            local time = os.date("%H:%M") -- show hour and minute in 24 hour format
            ---@cast time string
            return status.utils.stylize(time, {
              icon = { kind = "Clock", padding = { right = 1 } }, -- use our new clock icon
              padding = { right = 1 }, -- pad the right side so it's not cramped
            })
          end,
        },
        update = { -- update should happen when the mode has changed as well as when the time has changed
          "User", -- We can use the User autocmd event space to tell the component when to update
          "ModeChanged",
          callback = vim.schedule_wrap(function(_, args)
            if -- update on user UpdateTime event and mode change
              (args.event == "User" and args.match == "UpdateTime")
              or (args.event == "ModeChanged" and args.match:match(".*:.*"))
            then
              vim.cmd.redrawstatus() -- redraw on update
            end
          end),
        },
        hl = status.hl.get_attributes("mode"), -- highlight based on mode attributes
        surround = { separator = "right", color = status.hl.mode_bg }, -- background highlight based on mode
      }),
    }

    -- Now that we have the component, we need a timer to emit the User UpdateTime event
    vim.uv.new_timer():start( -- timer for updating the time
      (60 - tonumber(os.date("%S"))) * 1000, -- offset timer based on current seconds past the minute
      60000, -- update every 60 seconds
      vim.schedule_wrap(function()
        vim.api.nvim_exec_autocmds( -- emit our new User event
          "User",
          { pattern = "UpdateTime", modeline = false }
        )
      end)
    )

    local FileName = {
    provider = function(self)
        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifers
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return "[No Name]" end
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        -- See Flexible Components section below for dynamic truncation
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename
    end,
    hl = { fg = utils.get_highlight("Directory").fg },
    }
-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(FileNameBlock,
    FileIcon,
    utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
    FileFlags,
    { provider = '%<'} -- this means that the statusline is cut here when there's not enough space
)
  end,
}
