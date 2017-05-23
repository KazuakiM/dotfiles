" brew install poppler
augroup MyPdfAutoCmd
    autocmd!
    autocmd BufWinEnter *.pdf execute 'new |read !pdftotext -nopgbrk -layout ' . expand("%:p") . ' -'
augroup END
