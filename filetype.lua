vim.filetype.add({
    extension = {
        bb = "bitbake",
        bbappend = "bitbake",
        bbclass = "bitbake",
        inc = "bitbake",
    },
    filename = {
        ["local.conf.sample"] = "bitbake",
    }
})
