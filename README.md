# vim-WordColor

vim function to highlight any words.

## Usage

```vim
:WordColor 'word'
```

To clear colors, you call the command with no argument.
```vim
:WordColor
```

## Variables

- g:word_color_highlight
    - A dictionary to set a highlight color. The contents are color list of foreground color (key name: 'fg') and background (key name:'bg'). The lengths of 'fg' and 'bg' should be the same.
- g:word_color_mapping
    - A mapping key to ```:WordColor```. If you don't set this variable, no key is mapped to ```:WordColor```.
- g:word_color_priority
    - A number to set the priority of match. The default value is 20, and the default value in matchadd function is 10.

