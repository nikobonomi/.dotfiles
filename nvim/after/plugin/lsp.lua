local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = true })
end)


-- selective format on save
lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['html'] = { 'html' },
        ['rust_analyzer'] = { 'rs' },
        ['jdtls'] = { 'java' },
        ['jsonls'] = { 'json' },
        ['yamlls'] = { 'yaml' },
        ['lua_ls'] = { 'lua' },
        ['lemminx'] = { 'xml' },

    }
})

-- eslint fix on save for ts and js files
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
    command = 'silent! EslintFixAll',
    group = vim.api.nvim_create_augroup('MyAutocmdsJavaScripFormatting', {}),
})


require('lspconfig').tsserver.setup({
    single_file_support = false,
    on_attach = function(client, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set('n', '<A-o>',
            '<cmd>lua vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})<cr>',
            opts)
    end
})

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver',
        'angularls',
        'html',
        'jsonls',
        'yamlls',
        'lua_ls',
        'jdtls',
        'rust_analyzer',
        'lemminx',
        'eslint' },
    handlers = {
        lsp_zero.default_setup,
        jdtls = lsp_zero.noop
    },
})
