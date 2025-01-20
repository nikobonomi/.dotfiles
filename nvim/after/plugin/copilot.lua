require('copilot').setup({
    panel = {
        auto_refresh = true,
        layout = {
            position = "right"
        }
    },
    suggestion = {
        auto_trigger = true,
        keymap = {
            accept = "<C-l>",
            next = "<C-A-l>",
        }
    }
})
