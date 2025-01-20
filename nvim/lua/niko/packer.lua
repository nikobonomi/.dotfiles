-- This file can be loaded by calling `lua require('plugins')` from your init.vim


local install_path = '~/.local/share/nvim/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    print("installo packer")
    vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.api.nvim_command('autocmd VimEnter * PackerInstall')
    print("packer installed, restart nvim and type :PackerSync")
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim',
        config = function()
            require('mason').setup({})
        end }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use 'navarasu/onedark.nvim'

    use 'christoomey/vim-tmux-navigator'

    use 'nvim-treesitter/nvim-treesitter-context'

    use {
        'VonHeikemen/fine-cmdline.nvim',
        requires = {
            { 'MunifTanjim/nui.nvim' }
        }
    }

    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

    use({
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        after = "nvim-web-devicons",       -- keep this if you're using NvChad
    })


    use {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
    }

    use "sindrets/diffview.nvim"

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use 'mbbill/undotree'

    use 'lewis6991/gitsigns.nvim'

    use { "zbirenbaum/copilot.lua" }
    use {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end
    }
    use 'AndreM222/copilot-lualine'

    use("petertriho/nvim-scrollbar")

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },

            -- jdtls extension
            { 'mfussenegger/nvim-jdtls' },
            { 'nvim-neotest/nvim-nio' },

            { 'rcarriga/nvim-dap-ui' },
            { 'rcarriga/cmp-dap' },
            { 'mfussenegger/nvim-dap' },

        }
    }

    use "ray-x/lsp_signature.nvim"

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use { 'goolord/alpha-nvim' }
    use { 'windwp/nvim-ts-autotag' }

    use { "windwp/nvim-autopairs" }

    use "lukas-reineke/indent-blankline.nvim"

    use 'ja-ford/delaytrain.nvim'

    --use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }
end)
