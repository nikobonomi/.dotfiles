local lsp_signature_config = {
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
        border = "rounded"
    }
}

vim.api.nvim_create_user_command('LspInfo', function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filetype = vim.bo[bufnr].filetype
    local lines = { 'LSP Info', '', 'Buffer: ' .. vim.api.nvim_buf_get_name(bufnr), 'Filetype: ' .. filetype, '', 'Attached clients:' }
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    if #clients == 0 then
        table.insert(lines, '  none')
    else
        for _, client in ipairs(clients) do
            table.insert(lines, string.format(
                '  %s (id: %d, %s)',
                client.name,
                client.id,
                client:is_stopped() and 'stopped' or 'running'
            ))
            table.insert(lines, '    root: ' .. (client.root_dir or 'none'))
        end
    end

    table.insert(lines, '')
    table.insert(lines, 'Enabled for this filetype:')
    local enabled = {}
    for name, config in pairs(vim.lsp.config) do
        if config.filetypes and vim.tbl_contains(config.filetypes, filetype) and vim.lsp.is_enabled(name) then
            table.insert(enabled, name)
        end
    end
    table.sort(enabled)
    table.insert(lines, #enabled > 0 and '  ' .. table.concat(enabled, ', ') or '  none')

    local info_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(info_buf, 0, -1, false, lines)
    vim.bo[info_buf].filetype = 'lspinfo'
    vim.bo[info_buf].modifiable = false
    vim.bo[info_buf].bufhidden = 'wipe'
    vim.api.nvim_open_win(info_buf, true, {
        relative = 'editor',
        width = math.min(90, math.max(50, vim.o.columns - 8)),
        height = math.min(#lines, math.max(10, vim.o.lines - 6)),
        col = math.max(0, math.floor((vim.o.columns - math.min(90, math.max(50, vim.o.columns - 8))) / 2)),
        row = math.max(0, math.floor((vim.o.lines - math.min(#lines, math.max(10, vim.o.lines - 6))) / 2)),
        style = 'minimal',
        border = 'rounded',
        title = ' LSP Info ',
        title_pos = 'center',
    })
end, { desc = 'Show LSP clients for the current buffer' })

-- LSP attach configuration
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local bufnr = ev.buf
        local opts = { buffer = bufnr }
        
        -- Default keymaps (matching lsp-zero defaults, avoid F3/F4 for DAP)
        -- Note: 'gr' is mapped to telescope.lsp_references in remap.lua
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
        
        require('lsp_signature').on_attach(lsp_signature_config, bufnr)

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client.name == "jdtls" then
          client.server_capabilities.semanticTokensProvider = nil
          vim.keymap.set('n', '<leader>tc', ":JavaTestRunCurrentClass", opts)
          vim.keymap.set('n', '<leader>tt', ":JavaTestRunCurrentMethod", opts)
        end
    end,
})

-- Format on save for specific filetypes
local format_on_save_filetypes = {
    html = false,
    rs = false,
    json = false,
    yaml = false,
    lua = false
}

vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('LspFormatOnSave', {}),
    callback = function(ev)
        local ft = vim.bo[ev.buf].filetype
        if format_on_save_filetypes[ft] then
            vim.lsp.buf.format({ timeout_ms = 10000 })
        end
    end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { '*.java' },
    command = 'silent !google-java-format -r %',
})

vim.filetype.add {
    pattern = {
        ['.*/openapi/.*%.ya?ml'] = 'yaml.openapi',
        ['.*/openapi/.*%.ya?ml'] = 'yaml.openapi',
        ['.*/openapi/.*%.json'] = 'json.openapi',
    },
}

-- eslint fix on save for ts and js files
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
    command = 'silent! EslintFixAll',
    group = vim.api.nvim_create_augroup('MyAutocmdsJavaScripFormatting', {}),
})

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { '*.xml' },
    command = 'silent !xmlformat --overwrite --blanks %',
})


-- Configure LSP servers
local servers = {
    'ts_ls',
    'angularls',
    'html',
    'jsonls',
    'marksman',
    'yamlls',
    'lua_ls',
    'rust_analyzer',
    'lemminx',
    'tsp_server',
    'eslint'
}

-- Setup Mason and ensure servers are installed
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = servers,
})

-- Get capabilities for LSP servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure each server using vim.lsp.config
for _, server in ipairs(servers) do
    if server ~= 'jdtls' then -- Skip jdtls as it's handled separately
        vim.lsp.config(server, {
            capabilities = capabilities,
        })
    end
end

-- Special configuration for ts_ls
vim.lsp.config.ts_ls.cmd = { 'typescript-language-server', '--stdio' }
vim.lsp.config.ts_ls.filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
vim.lsp.config.ts_ls.root_dir = function(fname)
    return vim.fs.root(fname, { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' })
end

-- Enable all configured servers
vim.lsp.enable(servers)
