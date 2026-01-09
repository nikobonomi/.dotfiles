require('copilot').setup({
    copilot_node_command = vim.fn.expand('~/.nvm/versions/node/v24.11.1/bin/node'),
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
