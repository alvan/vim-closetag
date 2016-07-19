" == "acomment" == {{{
"
"      Modified:  2016-07-19 by Alvan
"   Description:  Auto close tag.
"                 Based on xml.vim(http://www.vim.org/scripts/script.php?script_id=1397)
"
" --}}}
"
if exists("g:loaded_closetag")
    finish
endif
let g:loaded_closetag = "1.6.1"

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin_closetag")
    finish
endif

if !exists('g:closetag_filenames')
    let g:closetag_filenames = "*.html,*.xhtml,*.phtml"
endif

if g:closetag_filenames == ""
    finish
endif

exec "au BufNewFile,Bufread " . g:closetag_filenames . " inoremap <silent> <buffer> > ><Esc>:call <SID>CloseTagFun()<Cr>"

" Script rgular expresion used. Documents those nasty criters      {{{1
let s:NoSlashBeforeGt = '\(\/\)\@\<!>'
" Don't check for quotes around attributes!!!
let s:Attrib =  '\(\(\s\|\n\)\+\([^>= \t]\+=[^>&]\+\)\(\s\|\n\)*\)'
let s:OptAttrib = s:Attrib . '*'. s:NoSlashBeforeGt
let s:ReqAttrib = s:Attrib . '\+'. s:NoSlashBeforeGt
let s:EndofName = '\($\|\s\|>\)'

" Buffer variables                                                  {{{1
fun! s:InitBuf()
    let b:did_ftplugin_closetag = 1
    let b:emptyTags='^\(area\|base\|br\|col\|command\|embed\|hr\|img\|input\|keygen\|link\|meta\|param\|source\|track\|wbr\)$'
    let b:firstWasEndTag = 0
    let b:html_mode = 1
    let b:haveAtt = 0
    let b:closetag_use_xhtml = 0
    if exists('g:closetag_use_xhtml')
        let b:closetag_use_xhtml = g:closetag_use_xhtml
    elseif &filetype == 'xhtml'
        let b:closetag_use_xhtml = 1
    en
endf
call s:InitBuf()

fun! s:SavePos()	
    retu 'call cursor('.line('.').','. col('.'). ')'
endf

fun! s:Callback(xml_tag, isHtml)
    let text = 0
    if a:isHtml == 1 && exists ("*HtmlAttribCallback")
        let text = HtmlAttribCallback (a:xml_tag)
    elseif exists ("*XmlAttribCallback")
        let text = XmlAttribCallback (a:xml_tag)
    endif       
    if text != '0'
        execute "normal! i " . text ."\<Esc>l"
    endif
endf

" GetTagName() Gets the tagname from start position                     {{{1
"Now lets go for the name part. The namepart are xmlnamechars which
"is quite a big range. We assume that everything after '<' or '</' 
"until the first 'space', 'forward slash' or '>' ends de name part.
fun! s:GetTagName(from)
    let l:end = match(getline('.'), s:EndofName,a:from)
    return strpart(getline('.'),a:from, l:end - a:from )
endf

" hasAtt() Looks for attribute in open tag                           {{{1
" expect cursor to be on <
fun! s:hasAtt()
    "Check if this open tag has attributes
    let l:line = line('.') | let l:col = col('.') 
    if search(b:tagName . s:ReqAttrib,'W') > 0
        if l:line == line('.') && l:col == (col('.')-1)
            let b:haveAtt = 1
        en
    en
endf

" TagUnderCursor()  Is there a tag under the cursor?               {{{1
" Set bufer wide variable
"  - b:firstWasEndTag
"  - b:tagName
"  - b:endcol & b:endline only used by Match()
"  - b:gotoCloseTag (if the tag under the cursor is one)
"  - b:gotoOpenTag  (if the tag under the cursor is one)
" on exit
"    - returns 1 (true)  or 0 (false)
"    - position is at '<'
fun! s:TagUnderCursor()
    let b:firstWasEndTag = 0
    let l:haveTag = 0
    let b:haveAtt = 0

    "Lets find forward a < or a >.  If we first find a > we might be in a tag.
    "If we find a < first or nothing we are definitly not in a tag

    if getline('.')[col('.') - 1] == '>'
        let b:endcol  = col('.')
        let b:endline = line('.')
        if getline('.')[col('.')-2] == '/'
            "we don't work with empty tags
            retu l:haveTag
        en
        " begin: gwang customization for JSP development
        if getline('.')[col('.')-2] == '%'
            "we don't work with jsp %> tags
            retu l:haveTag
        en
        " end: gwang customization for JSP development
        " begin: gwang customization for PHP development
        if getline('.')[col('.')-2] == '?'
            "we don't work with php ?> tags
            retu l:haveTag
        en
        if getline('.')[col('.')-2] == '='
            "we don't work with operator =>
            retu l:haveTag
        en
        " end: gwang customization for PHP development
    elseif search('[<>]','W') >0
        if getline('.')[col('.')-1] == '>'
            let b:endcol  = col('.')
            let b:endline = line('.')
            if getline('.')[col('.')-2] == '-'
                "we don't work with comment tags
                retu l:haveTag
            en
            if getline('.')[col('.')-2] == '/'
                "we don't work with empty tags
                retu l:haveTag
            en
        el
            retu l:haveTag
        en
    el
        retu l:haveTag
    en

    if search('[<>]','bW') >=0
        if getline('.')[col('.')-1] == '<'
            if getline('.')[col('.')] == '/'
                let b:firstWasEndTag = 1
                let b:gotoCloseTag = s:SavePos()
            elseif getline('.')[col('.')] == '?' ||  getline('.')[col('.')] == '!'
                "we don't deal with processing instructions or dtd
                "related definitions
                retu l:haveTag
            el
                let b:gotoOpenTag = s:SavePos()
            en
        el
            retu l:haveTag
        en
    el
        retu l:haveTag
    en

    "we have established that we are between something like
    "'</\?[^>]*>'

    let b:tagName = s:GetTagName(col('.') + b:firstWasEndTag)
    "echo 'Tag ' . b:tagName 

    "begin: gwang customization, do not work with an empty tag name
    if b:tagName == '' 
        retu l:haveTag
    en
    "end: gwang customization, do not work with an empty tag name

    let l:haveTag = 1
    if b:firstWasEndTag == 0
        call s:hasAtt()
        if exists('b:gotoOpenTag') && b:gotoOpenTag != ''
            exe b:gotoOpenTag
        en
    en
    retu l:haveTag
endf

fun! s:CloseTagFun()
    if !exists("b:did_ftplugin_closetag")
        call s:InitBuf()
    en

    let l:restore =  s:SavePos()
    let l:endOfLine = ((col('.')+1) == col('$'))
    if col('.') > 1 && getline('.')[col('.')-2] == '>'
        "Multiline request. <t>></t> -->
        "<t>
        "	    cursor comes here
        "</t>
        normal! h
        if s:TagUnderCursor()
            if b:firstWasEndTag == 0
                if exists('b:did_indent') && b:did_indent == 1
                    exe "normal! 2f>a\<Cr>\<Esc>k$i\<Cr>\<Esc>$"
                else
                    exe "normal! 2f>a\<Cr>\<Esc>k$i\<Cr>\<Esc>>>$"
                en
                call setline('.', strpart(getline('.'), 0, strlen(getline('.'))-1))

                start!
                retu
            en
        en
    elseif s:TagUnderCursor()
        if b:firstWasEndTag == 0
            exe "silent normal! />\<Cr>"
            if b:html_mode && b:tagName =~?  b:emptyTags
                if b:haveAtt == 0
                    call s:Callback (b:tagName, b:html_mode)
                en
                if b:closetag_use_xhtml
                    exe "normal! i/\<Esc>l"
                en
                if l:endOfLine
                    start!
                    retu
                el
                    normal! l
                    start
                    retu
                en
            el
                if b:haveAtt == 0
                    call s:Callback (b:tagName, b:html_mode)
                en
                exe "normal! a</" . b:tagName . ">\<Esc>F<"
                start
                retu
            en
        en
    en
    exe l:restore
    if (col('.')+1) == col("$")
        startinsert!
    else
        normal! l
        startinsert
    en
endf
" End of file : closetag.vim
