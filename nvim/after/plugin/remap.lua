local telescope_builtin = require('telescope.builtin')
local ufo = require('ufo')
local harpoon = require("harpoon")
local dap = require('dap')
local dapui = require('dapui')
local jdtls = require('jdtls')

vim.g.mapleader = " "

-- general
vim.keymap.set("n", "<leader>qq", ":q<CR>")
vim.keymap.set("n", "<leader>qa", ":qa<CR>")
vim.keymap.set("n", "<leader>ss", ":w<CR>")
vim.keymap.set("n", "<leader>qs", ":wq<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("v", "<leader>y", "\"+y")

-- resize splits
vim.keymap.set("n", "<C-A-j>", "20<C-w>+")
vim.keymap.set("n", "<C-A-k>", "20<C-w>-")
vim.keymap.set("n", "<C-A-l>", "20<C-w>>")
vim.keymap.set("n", "<C-A-h>", "20<C-w><")

-- command window
vim.api.nvim_set_keymap('n', ';', '<cmd>FineCmdline<CR>', { noremap = true })

-- diffview
vim.keymap.set("n", "<leader>do", ":DiffviewOpen<CR>")
vim.keymap.set("n", "<leader>dc", ":DiffviewClose<CR>")
vim.keymap.set("n", "<leader>dr", ":DiffviewRefresh<CR>")

-- goto
vim.keymap.set("n", "<C-g>", ":HopWord<CR>")

--telescope
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', function() telescope_builtin.buffers({ sort_mru = true }) end, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fd', telescope_builtin.diagnostics, {})
vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, {})
vim.keymap.set('n', '<leader>gf', telescope_builtin.git_files, {})


-- filetree
vim.keymap.set("n", "<leader>fe", ":NvimTreeToggle<CR>")

-- folds
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
vim.keymap.set('n', 'zm', ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

-- harpoon
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<A-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<A-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<A-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<A-k>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end)

-- Debug
vim.keymap.set('n', '<leader>da', dap.continue)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { noremap = true })
vim.keymap.set('n', '<leader>du', dapui.toggle)
vim.keymap.set('n', '<leader>ev', dapui.eval)

vim.keymap.set('n', '<leader>rl', dap.run_last)
vim.keymap.set('n', '<F3>', dap.continue)
vim.keymap.set('n', '<F4>', dap.step_over)
vim.keymap.set('n', '<F5>', dap.step_into)
vim.keymap.set('n', '<S-F5>', dap.step_out)

-- lsp navigation
vim.keymap.set("n", "<leader>en",
    function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end)
vim.keymap.set("n", "<leader>ep",
    function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end)
vim.keymap.set("n", "<leader>ed", vim.diagnostic.open_float)

-- actions
vim.keymap.set({ "n", "v" }, "<A-a>", vim.lsp.buf.code_action)
vim.keymap.set({ "n", "v" }, "<leader>fo", function() vim.lsp.buf.format({ timeout_ms = 10000 }) end, {})

-- signature help
vim.keymap.set({ 'n' }, 'gs', function() require('lsp_signature').toggle_float_win() end,
    { silent = true, noremap = true, desc = 'toggle signature' })

-- theme toggle
vim.keymap.set('n', '<leader>ts', require("onedark").toggle)
