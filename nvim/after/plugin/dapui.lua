local dap = require('dap')
local dapui = require('dapui')

dapui.setup()

function attach_to_debug()
    dap.configurations.java = {
        {
            type = 'java',
            request = 'attach',
            name = "Attach to the process",
            hostName = 'localhost',
            port = '5005',
        },
    }
    dap.continue()
end
