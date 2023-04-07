-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use 'tomasr/molokai'
	use 'EdenEast/nightfox.nvim'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'petertriho/nvim-scrollbar'
	-- use 'rstacruz/vim-closer'
	use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
	use { 'SmiteshP/nvim-navic', requires = 'neovim/nvim-lspconfig'	}
	use 'akinsho/bufferline.nvim'
	use 'norcalli/nvim-colorizer.lua'
	use {
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v2.x',
		requires = {
			'nvim-lua/plenary.nvim',
			'kyazdani42/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
		}
	}

	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { 'nvim-lua/plenary.nvim' } }

	use 'sidebar-nvim/sidebar.nvim'
	use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons'	} }

	use 'rust-lang/rust.vim'

	use 'jose-elias-alvarez/null-ls.nvim'

	use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'

	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	use 'hrsh7th/cmp-nvim-lsp-document-symbol'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-calc'
	use 'hrsh7th/cmp-emoji'

	use 'dcampos/nvim-snippy'
	use 'dcampos/cmp-snippy'

	use 'onsails/lspkind-nvim'

	use 'j-hui/fidget.nvim'

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'andymass/vim-matchup'
	use 'RRethy/nvim-treesitter-endwise'
	use 'RRethy/vim-illuminate'
	use 'p00f/nvim-ts-rainbow'
	use 'windwp/nvim-autopairs'

	use 'unblevable/quick-scope'
end)
