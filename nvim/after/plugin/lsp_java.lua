require('java').setup({
    spring_boot_tools = {
        enable = true,
    },
})

vim.lsp.config.jdtls.init_options.extendedClientCapabilities.advancedOrganizeImportsSupport = false

vim.lsp.config('jdtls', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    settings = {
        java = {
            configuration = {
                updateBuildConfiguration = 'interactive',
            },
            eclipse = {
                downloadSources = true,
            },
            maven = {
                downloadSources = true,
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
        },
    },
})

vim.lsp.enable('jdtls')

vim.api.nvim_create_user_command('JavaRestart', function()
    vim.lsp.enable('jdtls', false)
    for _, client in ipairs(vim.lsp.get_clients({ name = 'jdtls' })) do
        client:stop(true)
    end
    vim.defer_fn(function()
        vim.lsp.enable('jdtls')
    end, 500)
end, { desc = 'Restart JDTLS' })
