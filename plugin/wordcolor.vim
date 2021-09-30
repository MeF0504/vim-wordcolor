
if exists('g:loaded_wordcolor')
    finish
endif
let g:loaded_wordcolor = 1

if has('gui_running')
    let s:word_color_hi_default = {
                \ 'bg': ['Black', 'Maroon', 'Green', 'Olive', 'Navy', 'Purple', 'Teal', 'Silver', 'Grey', 'Red', 'Lime', 'Yellow', 'Blue', 'Fuchsia', 'Aqua', 'White'],
                \ 'fg': ['White', 'White', 'Black', 'Black', 'Black', 'Black', 'Black', 'Black', 'White', 'White', 'Black', 'Black', 'Black', 'Black', 'Black', 'Black'],
                \ }
else
    let s:word_color_hi_default = {
                \ 'bg': [  0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,  15],
                \ 'fg': [255, 255, 233, 233, 233, 233, 233, 233, 255, 255, 233, 233, 233, 233, 233, 233],
                \ }
endif
let g:word_color_highlight = get(g:, 'word_color_highlight', s:word_color_hi_default)
let g:word_color_default = get(g:, 'word_color_default', 'match')

let s:word_color_ids = []
function! s:set_word_color(...) abort
    if a:0 == 0
        for id in s:word_color_ids
            call matchdelete(id)
        endfor
        let s:word_color_ids = []
        return
    endif

    let wd = a:1
    let color_num = len(g:word_color_highlight['fg'])
    if len(g:word_color_highlight['bg']) != color_num
        echo 'invalid highlight setting. use default value'
        let g:word_color_highlight = s:word_color_hi_default
    endif

    let cnt = len(s:word_color_ids)%color_num
    if has('gui_running')
        let tname = 'gui'
    else
        let tname = 'cterm'
    endif
    execute "highlight WordColor" . cnt .
                \ " ".tname."fg=" . (g:word_color_highlight['fg'][cnt]) .
                \ " ".tname."bg=" . (g:word_color_highlight['bg'][cnt])
    let id = matchadd("WordColor".cnt, wd, 50)
    call add(s:word_color_ids, id)
endfunction

command! -nargs=? WordColor call s:set_word_color(<f-args>)

if exists('g:word_color_mapping')
    execute 'nnoremap '.g:word_color_mapping.' :WordColor<space>'
endif


