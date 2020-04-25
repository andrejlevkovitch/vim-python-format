# vim-python-format

# Install

1. You need first install yapf

```bash
pip3 install yapf
```

2. Add this plugin to vim by `vundle`

3. Add next lines to your `.vimrc`:

```vim
autocmd FileType python nnoremap <buffer> <c-k> :call PythonFormat()<cr>
autocmd BufWrite *.py call PythonFormat()
```
