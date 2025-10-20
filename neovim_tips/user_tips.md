# Your personal Neovim tips

# Title: Move selected lines
# Category: Editing
# Tags: move, line, lines, motion, visual, selection
---

Move selected lines in visual mode with correct indentation

```vim
:m '<-2<cr>gv=gv " Move up
:m '>+1<cr>gv=gv " Move down
```

***

# Title: Join lines while leaving the cursor same
# Category: Key Mappings
# Tags: move, line, join, cursor, map
---

Leaves the cursor in the same place as it was before joining lines

```vim
:nnoremap J mzJ`z
```

***

# Title: Search within visual selection
# Category: Key Mappings
# Tags: search, visual, selection, range, map
---

```vim
" Search forward
:vmap z/ <C-\><C-n>`</\%V
" Search backward
:vmap z? <C-\><C-n>`>?\%V
```

***
