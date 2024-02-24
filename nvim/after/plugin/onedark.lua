require('onedark').setup {
    style = 'deep',
    transparent = false,
    toggle_style_key = '<leader>ts',  -- nil to disable or set it to a string, for example "<leader>ts"
    toggle_style_list = { 'darker', 'deep', 'warmer', 'light' },
    lualine = {
        transparent = false, -- lualine center bar transparency
    },
}
require('onedark').load()
