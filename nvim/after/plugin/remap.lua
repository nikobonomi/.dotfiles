local telescope_builtin = require('telescope.builtin')
local ufo = require('ufo')
local harpoon = require("harpoon")
local dap = require('dap')
local dapui = require('dapui')

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fe", ":NvimTreeToggle<CR>")

vim.api.nvim_set_keymap('n', ';', '<cmd>FineCmdline<CR>', { noremap = true })

vim.keymap.set("n", "<leader>qq", ":q<CR>")
vim.keymap.set("n", "<leader>qa", ":qa<CR>")
vim.keymap.set("n", "<leader>ss", ":w<CR>")
vim.keymap.set("n", "<leader>qs", ":wq<CR>")

vim.keymap.set("n", "<leader>do", ":DiffviewOpen<CR>")
vim.keymap.set("n", "<leader>dc", ":DiffviewClose<CR>")
vim.keymap.set("n", "<leader>dr", ":DiffviewRefresh<CR>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])

vim.keymap.set("n", "<C-g>", ":HopWord<CR>")

vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', function() telescope_builtin.buffers({ sort_mru = true }) end, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, {})
vim.keymap.set('n', '<leader>gf', telescope_builtin.git_files, {})

vim.keymap.set("n", "<leader>gs", vim.cmd.Git);

vim.keymap.set("n", "<leader>ft", ":NvimTreeToggle<CR>", { silent = true });

vim.keymap.set("n", "<leader>co", ":BufferLineCloseOthers<CR>", { silent = true });
vim.keymap.set("n", "<leader>cc", ":enew<bar>bd #<CR>", { silent = true });
vim.keymap.set("n", "<C-A-n>", ":BufferLineCycleNext<CR>", { silent = true });
vim.keymap.set("n", "<C-A-p>", ":BufferLineCyclePrev<CR>", { silent = true });

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
vim.keymap.set('n', '<leader>da', attach_to_debug)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { noremap = true })
vim.keymap.set('n', '<leader>du', dapui.toggle)

vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F8>', dap.step_over)
vim.keymap.set('n', '<F7>', dap.step_into)
vim.keymap.set('n', '<S-F8>', dap.step_out)
