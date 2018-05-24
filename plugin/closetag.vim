if !exists('g:closetag_filetypes')
    let g:closetag_filetypes = 'html,xhtml,phtml'
endif

if !exists('g:closetag_xhtml_filetypes')
    let g:closetag_xhtml_filetypes = 'xhtml'
endif

if !exists('g:closetag_filenames')
    " no need for html/xhtml here, as the ft is set correctly for those
    let g:closetag_filenames = '*.phtml'
endif

if !exists('g:closetag_xhtml_filenames')
    " no need for xhtml here, as its ft is set correctly
    let g:closetag_xhtml_filenames = ''
endif

if !exists('g:closetag_shortcut')
    let g:closetag_shortcut = '>'
endif

if !exists('g:closetag_close_shortcut')
    let g:closetag_close_shortcut = ''
endif

if !exists('g:closetag_emptyTags_caseSensitive')
    let g:closetag_emptyTags_caseSensitive = 0
endif

let g:closetag_filenames = substitute(g:closetag_filenames, '\s*,\s\+', ',', 'g')
let g:closetag_xhtml_filenames = substitute(g:closetag_xhtml_filenames, '\s*,\s\+', ',', 'g')
let g:closetag_filetypes = substitute(g:closetag_filetypes, '\s*,\s\+', ',', 'g')
let g:closetag_xhtml_filetypes = substitute(g:closetag_xhtml_filetypes, '\s*,\s\+', ',', 'g')

if g:closetag_shortcut != ''
    exec "au User vim-closetag inoremap <silent> <buffer> " . g:closetag_shortcut . " ><Esc>:call closetag#Closure()<Cr>"

    if g:closetag_filetypes != ''
        exec "au FileType " . g:closetag_filetypes . " inoremap <silent> <buffer> " . g:closetag_shortcut . " ><Esc>:call closetag#Closure()<Cr>"
    en
    if g:closetag_filenames != ''
        exec "au BufNewFile,Bufread " . g:closetag_filenames . " inoremap <silent> <buffer> " . g:closetag_shortcut . " ><Esc>:call closetag#Closure()<Cr>"
    en
en

if g:closetag_close_shortcut != ''
    if g:closetag_filetypes != ''
        exec "au FileType " . g:closetag_filetypes . " inoremap <silent> <buffer> " . g:closetag_close_shortcut . " >"
    en
    if g:closetag_filenames != ''
        exec "au BufNewFile,Bufread " . g:closetag_filenames . " inoremap <silent> <buffer> " . g:closetag_close_shortcut . " >"
    en
en

if g:closetag_xhtml_filetypes != ''
    exec "au FileType " . g:closetag_xhtml_filetypes . " call closetag#Declare('b:closetag_use_xhtml', 1)"
en
if g:closetag_xhtml_filenames != ''
    exec "au BufNewFile,Bufread " . g:closetag_xhtml_filenames . " call closetag#Declare('b:closetag_use_xhtml', 1)"
en
