local lsp_signature_config = {
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
        border = "rounded"
    }
}

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
    pattern = { '*.java' },
    command = 'silent !google-java-format -r %',
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
