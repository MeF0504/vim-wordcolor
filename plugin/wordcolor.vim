
if exists('g:loaded_wordcolor')
    finish
endif
let g:loaded_wordcolor = 1

let s:word_color_hi_default = [
            \ ['White', 'Maroon',  255, 1 ],
            \ ['Black', 'Green',   233, 2 ],
            \ ['Black', 'Olive',   233, 3 ],
            \ ['Black', 'Navy',    233, 4 ],
            \ ['Black', 'Purple',  233, 5 ],
            \ ['Black', 'Teal',    233, 6 ],
            \ ['White', 'Red',     255, 9 ],
            \ ['Black', 'Lime',    233, 10],
            \ ['Black', 'Yellow',  233, 11],
            \ ['Black', 'Blue',    233, 12],
            \ ['Black', 'Fuchsia', 233, 13],
            \ ['Black', 'Aqua',    233, 14],
            \ ]
let g:word_color_highlight = get(g:, 'word_color_highlight', s:word_color_hi_default)

function! s:set_word_color(...) abort
    if !exists('w:word_color_ids')
        let w:word_color_ids = []
    endif
    if a:0 == 0
        for id in w:word_color_ids
            call matchdelete(id)
        endfor
        let w:word_color_ids = []
        return
    endif

    let wd = a:1
    let color_num = len(g:word_color_highlight)

    let cnt = len(w:word_color_ids)%color_num
    execute printf('highlight WordColor%d guifg=%s guibg=%s ctermfg=%s ctermbg=%s',
                \ cnt,
                \ g:word_color_highlight[cnt][0],
                \ g:word_color_highlight[cnt][1],
                \ g:word_color_highlight[cnt][2],
                \ g:word_color_highlight[cnt][3],
                \ )

    let priority = get(g:, 'word_color_priority', 20)
    let id = matchadd("WordColor".cnt, wd, priority)
    call add(w:word_color_ids, id)
endfunction

command! -nargs=? WordColor call s:set_word_color(<f-args>)

if exists('g:word_color_mapping')
    execute 'nnoremap '.g:word_color_mapping.' :WordColor<space>'
endif

