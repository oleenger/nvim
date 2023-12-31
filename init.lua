local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
use "nvim-lua/plenary.nvim" -- don't forget to add this one if you don't have it yet!
use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} }
}
    use({"neanias/everforest-nvim", config = function() require("everforest").setup() end, })
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.5', requires = { {'nvim-lua/plenary.nvim'} } }
--    use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
    use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
    use 'nanozuki/tabby.nvim'
    use 'tpope/vim-commentary'

    -- Syntax parser
    use("nvim-treesitter/nvim-treesitter")

    -- Completion
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-path")
    use("hrsh7th/nvim-cmp")

    use("tpope/vim-fugitive")

    -- Snippets 
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    -- Formatting
    use("jose-elias-alvarez/null-ls.nvim")
    -- Language server
    use("neovim/nvim-lspconfig")
    use("williamboman/nvim-lsp-installer")

    -- Utilities
    use("windwp/nvim-autopairs")
    use("norcalli/nvim-colorizer.lua")
    use("lewis6991/gitsigns.nvim")

    --Data Science
    use 'preservim/vimux'
    use 'greghor/vim-pyShell'
    use 'julienr/vim-cellmode'

    use {
        'nvim-tree/nvim-tree.lua',
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    if packer_bootstrap then
        require('packer').sync()

        require("everforest").setup({ background = "hard" })

        require("nvim-autopairs").setup({
            disable_filetype = { "TelescopePrompt" },
        })
        require("colorizer").setup()
        require("gitsigns").setup()

    end

    require('opts')
    require('remaps')
    require('cmd')
    require('plugins.nvim-tree')
    require('plugins.telescope')
    require('plugins.tabby')
    require('plugins.treesitter')
    require('plugins.lualine')
--    require('plugins.indent_blanklines')

end)

