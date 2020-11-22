# vim-WordColor

vim function to highlight any words.

## Usage

```vim
:WordColor
```

If you want to specify the syntax type,
```vim
:WordColorMatch
" or
:WordColorKeyWord
```

## Variables

- g:word_color_highlight
    - A dictionary to set a highlight color. The contents are color list of foreground color (key name: 'fg') and background (key name:'bg'). The lengths of 'fg' and 'bg' should be the same.
- g:word_color_default
    - A string to set the default syntax type of ```:WordColor```. 'match' and 'keyword' can be set, and ```:WordColorMatch``` and ```:WordColorKeyWord``` are called from ```:WordColor``` respectively.
- g:word_color_mapping
    - A mapping key to ```:WordColor```. If you don't set this variable, no key is mapped to ```:WordColor```.

