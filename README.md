# vim-python-format

You need:

- Install yapf:
  ```sh
  apt-get install yapf
  ```
- Add path to installed package (`yapf`) to your `PATH`
- Add next lines to your `.vimrc`:
```vim
function! PythonFormat()
  let text=getline(1, '$')
  let result=system('yapf --style=chromium', text)
  if v:shell_error == 0 " all right
    " save cursor position
    let sourcepos=line(".")

    " change content
    call deletebufline(bufname("%"), 1, '$')
    call setline(1, split(result, '\n'))

    " and resotre cursor position
    call cursor(sourcepos, 0)
  else " we get errors
    cexpr result
    cwindow 5
  end
endfunction
autocmd FileType python nnoremap <buffer> <c-k> :call PythonFormat()<cr>
autocmd BufWrite *.py call PythonFormat()
```
