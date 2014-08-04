closetag.vim
============

Auto close tag, support xml files.

Just set this in your vimrc:

    # filenames like *.xml, *.html, *.xhtml, ...
    let g:closetag_filenames = "*.html,*.xhtml,*.phtml"

Then after you click &gt; in those files, this plugin will try to close the current tag for you.

#### Usage

For example, below is the current content:

    <table|

Now you press &gt;, the content will be:

    <table>|</table>

And now if you press &gt; again, the content will be:

    <table>
        |
    </table>


#### Install Detail

Just put the files into ~/.vim/ or &lt;HOMEDIR&gt;\vimfiles\ (for Windows).
