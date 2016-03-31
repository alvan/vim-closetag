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

#### Install

* Just put the files into ~/.vim/ or &lt;HOMEDIR&gt;\vimfiles\ (for Windows).

* Use vundle:

        Plugin 'alvan/vim-closetag'

* Use other package manager.

#### Options

You can set this in your vimrc:

    # filenames like *.xml, *.html, *.xhtml, ...
    let g:closetag_filenames = "*.html,*.xhtml,*.phtml"

Then after you press <kbd>&gt;</kbd> in these files, this plugin will try to close the current tag.

