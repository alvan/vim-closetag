closetag.vim
============

Auto close tag, support xml files.

Just set this in your vimrc:

    # filenames like *.xml, *.html, *.xhtml, ...
    let g:closetag_filenames = "*.html,*.xhtml,*.phtml"

Then after you double click &gt; in those files, this plugin will try to close the current tag for you.

For example, below is the current content:

    <table|

Now you press &gt;, the content will be:

    <table>|

You press &gt; again, and then the content will be:

    <table>
        |
    <table>


#### Install Detail

Just put the files into ~/.vim/ or &lt;HOMEDIR&gt;\vimfiles\ (for Windows).
