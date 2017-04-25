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

You can set this in your vimrc:

    " filenames like *.xml, *.html, *.xhtml, ...
    let g:closetag_filenames = "*.html,*.xhtml,*.phtml"

Then after you press <kbd>&gt;</kbd> in these files, this plugin will try to close the current tag.

You can set:

    let g:closetag_emptyTags_caseSensitive = 1
This will make the list of non closing tags case sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
