if did_filetype()
    finish
endif

augroup customFiletypes
    " Yocto Bitbake
    au! BufRead,BufNewFile *.bb set filetype=bitbake
    au! BufRead,BufNewFile *.bbappend set filetype=bitbake
    au! BufRead,BufNewFile *.bbclass set filetype=bitbake
    au! BufRead,BufNewFile *.inc set filetype=bitbake
augroup END
