local M = {}

local isempty = function(s)
  return s == nil or s == ""
end

vim.cmd [[
  highlight WinBar           guibg=None guifg=#BBBBBB gui=bold
  highlight WinBarHeader     guibg=None guifg=#BBBBBB gui=bold,underline
  highlight WinBarNC         guibg=None guifg=#888888 gui=bold
  highlight WinBarLocation   guibg=None guifg=#888888 gui=bold
  highlight WinBarModified   guibg=None guifg=#d7d787
  highlight WinBarGitDirty   guibg=None guifg=#d7afd7
  highlight WinBarIndicator  guibg=None guifg=#5fafd7 gui=bold
  highlight WinBarInactive   guibg=None guibg=#3a3a3a guifg=#777777 gui=bold

  highlight ModeC guibg=#dddddd guifg=#101010 gui=bold " COMMAND 
  highlight ModeI guibg=#ffff5f guifg=#353535 gui=bold " INSERT  
  highlight ModeT guibg=#95e454 guifg=#353535 gui=bold " TERMINAL
  highlight ModeN guibg=#87d7ff guifg=#353535 gui=bold " NORMAL  
  highlight ModeN guibg=#5fafd7 guifg=#262626 gui=bold " NORMAL  
  highlight ModeV guibg=#c586c0 guifg=#353535 gui=bold " VISUAL  
  highlight ModeR guibg=#f44747 guifg=#353535 gui=bold " REPLACE 

  highlight StatusLine              guibg=#303030 guifg=#999999
  highlight StatusLineGit  gui=bold guibg=#3a3a3a guifg=#c586c0
  highlight StatusLineCwd  gui=bold guibg=#3a3a3a guifg=#999999
  highlight StatusLineFile gui=bold guibg=#303030 guifg=#bbbbbb
  highlight StatusLineMod           guibg=#303030 guifg=#d7d787
  highlight StatusLineError         guibg=#303030 guifg=#ff0000
  highlight StatusLineInfo          guibg=#303030 guifg=#87d7ff
  highlight StatusLineHint          guibg=#303030 guifg=#ffffd7
  highlight StatusLineWarn          guibg=#303030 guifg=#d7d700
  highlight StatusLineChanges       guibg=#303030 guifg=#c586c0
  highlight StatusLineOutside       guibg=#3a3a3a guifg=#999999
  highlight StatusLineTransition1   guibg=#303030 guifg=#1c1c1c
  highlight StatusLineTransition2   guibg=#3a3a3a guifg=#1c1c1c

  function! FindHeader()
    " We need to find the header, it will be the first line that has:
    " | columnName |
    " in it.
    " We will only look at the first 100 lines.
    let b:table_header = 1
    for i in range(1, 100)
      let line = getline(i)
      let header = matchstr(line, '|\s.*\s|')
      if !empty(header)
        let b:table_header = i
        return
      endif
    endfor
  endfunction

  augroup dbout
    autocmd!
    autocmd BufReadPost *.dbout call FindHeader()
  augroup END
]]



_G.status = M
vim.o.winbar="%{%v:lua.status.get_winbar()%}"
vim.o.statusline="%{%v:lua.status.get_statusline()%}"

return M
