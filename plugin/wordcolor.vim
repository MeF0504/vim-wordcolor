
if exists('g:loaded_wordcolor')
    finish
endif
let g:loaded_wordcolor = 1

if has('gui_running')
    let s:word_color_hi_default = #{
                \ bg: ['Black', 'Maroon', 'Green', 'Olive', 'Navy', 'Purple', 'Teal', 'Silver', 'Grey', 'Red', 'Lime', 'Yellow', 'Blue', 'Fuchsia' 'Aqua', 'White'],
                \ fg: ['White', 'White', 'Black', 'Black', 'Black', 'Black', 'Black', 'Black', 'White', 'White', 'Black', 'Black', 'Black', 'Black', 'Black', 'Black'],
                \ }
else
    let s:word_color_hi_default = #{
                \ bg: [  0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,  15],
                \ fg: [255, 255, 233, 233, 233, 233, 233, 233, 255, 255, 233, 233, 233, 233, 233, 233],
                \ }
endif
let g:word_color_highlight = get(g:, 'word_color_highlight', s:word_color_hi_default)
let g:word_color_default = get(g:, 'word_color_default', 'match')

let g:word_color_cnt = [-1,-1]

function! s:set_word_color(...) abort
    if a:0 == 1
        for i in range(0, g:word_color_cnt[1])
            execute "syntax clear WordColor" . i
        endfor
        let g:word_color_cnt[0] = -1
        return
    endif

    let wd = a:2
    let color_num = len(g:word_color_highlight['fg'])
    if len(g:word_color_highlight['bg']) != color_num
        echo 'invalid highlight setting. use default value'
        let g:word_color_highlight = s:word_color_hi_default
    endif

    let g:word_color_cnt[0] += 1
    if g:word_color_cnt[0] >= color_num
        let g:word_color_cnt[0] = 0
    endif
    if g:word_color_cnt[1] < g:word_color_cnt[0]
        let g:word_color_cnt[1] = g:word_color_cnt[0]
    endif

    " containedin=ALLで優先表示
    if a:1 == 'match'
        " matchはpriorityが低いらしい
        " https://vim-jp.org/vimdoc-ja/syntax.html#:syn-priority
        let magic_words = ['(', ')', '<', '>', '|', '+', '?']
        for mw in magic_words
            let wd = substitute(wd, mw, '\\'.mw, 'g')
        endfor
        execute "syntax match WordColor" . g:word_color_cnt[0] . " containedin=ALL /" . wd . "/"
    elseif a:1 == 'keyword'
        execute "syntax keyword WordColor" . g:word_color_cnt[0] . " containedin=ALL " . wd
    else
        echoerr 'invalid setting of syntax type : ' . a:1
    endif

    if has('gui_running')
        let tname = 'gui'
    else
        let tname = 'cterm'
    endif
    execute "highlight WordColor" . g:word_color_cnt[0] .
                \ " ".tname."fg=" . (g:word_color_highlight['fg'][g:word_color_cnt[0]]) .
                \ " ".tname."bg=" . (g:word_color_highlight['bg'][g:word_color_cnt[0]])
endfunction

command! -nargs=? WordColorKeyWord call s:set_word_color('keyword', <f-args>)
command! -nargs=? WordColorMatch call s:set_word_color('match', <f-args>)
command! -nargs=? WordColor call s:set_word_color(g:word_color_default, <f-args>)

if exists('g:word_color_mapping')
    execute 'nnoremap '.g:word_color_mapping.' :WordColor<space>'
endif


