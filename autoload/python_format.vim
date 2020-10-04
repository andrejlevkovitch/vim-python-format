" help function for formatters
function python_format#CopyDiffToBuffer(input, output, bufname)
  " prevent out of range in cickle
  let min_len = min([len(a:input), len(a:output)])

  " copy all lines, that was changed
  for i in range(0, min_len - 1)
    let output_line = a:output[i]
    let input_line  = a:input[i]
    if input_line != output_line
      call setline(i + 1, output_line) " lines calculate from 1, items - from 0
    end
  endfor

  " in this case we have to handle all lines, that was in range
  if len(a:input) != len(a:output)
    if min_len == len(a:output) " remove all extra lines from input
      call deletebufline(a:bufname, min_len + 1, "$")
    else " append all extra lines from output
      call append("$", a:output[min_len:])
    end
  end

  " XXX if formatting is a long operation and we call after format start some
  " other command, then window will display invalid data. For prevent this we
  " just redraw the windows
  redraw!
endfunction


function python_format#format()
  let input       = getline(1, '$')
  let output_str  = system('yapf --style=chromium', input)
  if v:shell_error == 0 " all right
    let output = split(output_str, "\n")
    call python_format#CopyDiffToBuffer(input, output, bufname("%"))

    " and creare lbuffer
    lexpr ""
    lwindow
  else " we got errors
    lexpr output_str
    lwindow 5
  end
endfunction
autocmd FileType python nnoremap <buffer> <c-k> :call PythonFormat()<cr>
autocmd BufWrite *.py call PythonFormat()
