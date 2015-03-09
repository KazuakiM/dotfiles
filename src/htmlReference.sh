#!/bin/sh
#--------------------------------
# HTML Reference shell
#
# @author 2015-03-08 kazuakiM
#--------------------------------
#variable {{{
url=http://www.htmq.com/html/
outputDir=$HOME/.vim/vim-ref/php-chunked-xhtml/
tagList=(
    'a'              'abbr'         'acronym'    'address'  'applet'       'area'
    'b'              'base'         'basefont'   'bdo'      'bgsound'      'big'         'blink'        'blockquote' 'body'       'br'             'button'
    'caption'        'center'       'cite'       'code'     'col'          'colgroup'
    'dd'             'del'          'dfn'        'dir'      'div'          'dl'          'dt'
    'em'
    'fieldset'       'font'         'form'       'frame'    'frameset'
    'h'              'head'         'hr'         'html'
    'i'              'iframe'       'img'        'input'    'input_submit' 'input_image' 'input_button' 'button'     'input_text' 'input_password' 'input_radio'
    'input_checkbox' 'input_hidden' 'input_file' 'ins'      'isindex'
    'kbd'
    'label'          'legend'       'li'         'link'     'listing'
    'map'            'menu'         'meta'
    'nobr'           'noframes'     'noscript'
    'object'         'ol'           'optgroup'   'option'
    'p'              'param'        'plaintext'  'pre'
    'q'
    's'              'samp'         'script'     'select'   'small'        'span'        'strike'       'strong'     'style'      'sub'            'sup'
    'table'          'tbody'        'td'         'textarea' 'tfoot'        'th'          'thead'        'title'      'tr'         'tt'
    'u'              'ul'
    'var'
    'xmp')
#}}}
mkdir -p ${outputDir}
for tag in ${tagList[@]}; do
    wget "${url}${tag}.shtml" -P ${outputDir}
    #High Traffic NG
    sleep 10s
done
ln -sf $HOME/.vim/vim-ref/php-chunked-xhtml/h.shtml $HOME/.vim/vim-ref/php-chunked-xhtml/h1.shtml
ln -sf $HOME/.vim/vim-ref/php-chunked-xhtml/h.shtml $HOME/.vim/vim-ref/php-chunked-xhtml/h2.shtml
ln -sf $HOME/.vim/vim-ref/php-chunked-xhtml/h.shtml $HOME/.vim/vim-ref/php-chunked-xhtml/h3.shtml
ln -sf $HOME/.vim/vim-ref/php-chunked-xhtml/h.shtml $HOME/.vim/vim-ref/php-chunked-xhtml/h4.shtml
ln -sf $HOME/.vim/vim-ref/php-chunked-xhtml/h.shtml $HOME/.vim/vim-ref/php-chunked-xhtml/h5.shtml
ln -sf $HOME/.vim/vim-ref/php-chunked-xhtml/h.shtml $HOME/.vim/vim-ref/php-chunked-xhtml/h6.shtml
