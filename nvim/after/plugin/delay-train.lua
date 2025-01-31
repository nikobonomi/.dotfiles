require('delaytrain').setup {
    grace_period = 3,
    keys = { -- Which keys (in which modes) should be delayed
        ['nv'] = { 'h', 'j', 'k', 'l', 'e', 'b' }
    },
    ignore_filetypes = { "help", "NvimTr*" }

}
