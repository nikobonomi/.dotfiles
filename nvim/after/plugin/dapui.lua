local dap = require('dap')
local dapui = require('dapui')

local codelldb = require('mason-registry')
    .get_package('codelldb')
    :get_install_path()

dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        -- Change this to your path!
        command = codelldb .. '/codelldb',
        args = { "--port", "${port}" },
    }
}

dapui.setup()

function attach_to_debug()
    dap.configurations.rust = {
        {
            name = "Rust debug",
            type = "codelldb",
            request = "launch",
            program = function()
                vim.fn.jobstart('cargo build')
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            showDisassembly = "never"
        },
    }
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
