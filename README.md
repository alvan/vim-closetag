closetag.vim
================

#### Usage

The current content:

```vim
<table|
```

Now you press <kbd>&gt;</kbd>, the content will be:

```vim
<table>|</table>
```

And then if you press <kbd>&gt;</kbd> again, the content will be:

```vim
<table>
    |
</table>
```

The following tags will not be closed:

```html
<area>, <base>, <br>, <col>, <command>, <embed>, <hr>, <img>, 
<input>, <keygen>, <link>, <meta>, <param>, <source>, <track>, <wbr>,<menuitem>
```

#### Installation

* Just put the files into ~/.vim/ or &lt;HOMEDIR&gt;\vimfiles\ (for Windows).

* Use vundle:

```vim
Plugin 'alvan/vim-closetag'
```

* Use other package manager.

#### Options

Set in your vimrc:

```vim
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'
```

#### Commands

Use these commands to toggle enable/disable this function for current buffer:

```vim
:CloseTagToggleBuffer
:CloseTagEnableBuffer
:CloseTagDisableBuffer
```
