vim.opt.termguicolors = true

require("bufferline").setup {
    options = {
        numbers = "ordinal",
        indicator = {
            style = "underline"
        },
        separator_style = "thin",
        diagnostics = "nvim_lsp",
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                separator = " " -- use a "true" to enable the default, or set your own character
            }
        }
    }
}
