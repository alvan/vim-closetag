closetag.vim
============

#### Usage

For example, below is the current content:

    <table|

Now you press <kbd>&gt;</kbd>, the content will be:

    <table>|</table>

And now if you press <kbd>&gt;</kbd> again, the content will be:

    <table>
        |
    </table>

The following tags will not be closed:

    <area>, <base>, <br>, <col>, <command>, <embed>, <hr>, <img>, 
    <input>, <keygen>, <link>, <meta>, <param>, <source>, <track>, <wbr>

#### Install

* Just put the files into ~/.vim/ or &lt;HOMEDIR&gt;\vimfiles\ (for Windows).

* Use vundle:

        Plugin 'alvan/vim-closetag'

* Use other package manager.

#### Options

Set in your vimrc:

    " filenames like *.xml, *.html, *.xhtml, ...
    " These are the file extensions where this plugin is enabled.
    "
    let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

    " filenames like *.xml, *.xhtml, ...
    " This will make the list of non-closing tags self-closing in the specified files.
    "
    let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

    " integer value [0|1]
    " This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
    "
    let g:closetag_emptyTags_caseSensitive = 1

    " Shortcut for closing tags, default is '>'
    "
    let g:closetag_shortcut = '>'

    " Add > at current position without closing the current tag, default is ''
    "
    let g:closetag_close_shortcut = '<leader>>'

#### Commands

Use these commands to toggle enable/disable this function for current buffer:

    :CloseTagToggleBuffer
    :CloseTagEnableBuffer
    :CloseTagDisableBuffer

