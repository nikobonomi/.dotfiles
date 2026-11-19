local treesitter_runtime = vim.fn.stdpath('data') .. '/site/pack/packer/start/nvim-treesitter/runtime'
vim.opt.runtimepath:append(treesitter_runtime)

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('TreesitterHighlighting', { clear = true }),
    callback = function(event)
        pcall(vim.treesitter.start, event.buf)
    end,
})
