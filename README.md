# vim-WordColor

vim function to highlight any words.

<img src=images/wordcolor.gif width="70%">

***Caution***  
I think [vim-highlighter](https://github.com/azabiong/vim-highlighter) is better than this plugin.
I recommend to use this.

## Usage

```vim
:WordColor 'word'
" or, if there is no argument, highlight word under the cursor.
:WordColor
" clear colors
:WordColorClear
```

## Variables

- g:word_color_highlight
    - A list to set a highlight color. The contents are list of color setting, [guifg, guibg, ctermfg, ctermbg].
- g:word_color_mapping
    - A mapping key to ```:WordColor```. If you don't set this variable, no key is mapped to ```:WordColor```.
- g:word_color_priority
    - A number to set the priority of match. The default value is 20, and the default value in matchadd function is 10.

