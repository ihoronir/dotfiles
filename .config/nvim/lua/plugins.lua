return {
    "kaarmu/typst.vim",

    "EdenEast/nightfox.nvim",
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },
    "petertriho/nvim-scrollbar",
    { "nvim-lualine/lualine.nvim", requires = { "nvim-tree/nvim-web-devicons", opt = true } },
    { "SmiteshP/nvim-navic",       requires = "neovim/nvim-lspconfig" },
    "akinsho/bufferline.nvim",
    "norcalli/nvim-colorizer.lua",
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = { "nvim-lua/plenary.nvim" },
    },
    "sidebar-nvim/sidebar.nvim",
    { "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" } },
    "jose-elias-alvarez/null-ls.nvim",

    "neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",

    "dcampos/nvim-snippy",
    "dcampos/cmp-snippy",

    "nvim-lua/plenary.nvim",

    "onsails/lspkind-nvim",

    { "j-hui/fidget.nvim",       tag = "legacy" },

    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,
    },
    "andymass/vim-matchup",
    "RRethy/nvim-treesitter-endwise",
    "RRethy/vim-illuminate",
    "p00f/nvim-ts-rainbow",
    "windwp/nvim-autopairs",

    --"unblevable/quick-scope",
}

-- return require("packer").startup(function(use)
--     use("wbthomason/packer.nvim")
--
--     use("kaarmu/typst.vim")
--
--     use("EdenEast/nightfox.nvim")
--     use("lukas-reineke/indent-blankline.nvim")
--     use("petertriho/nvim-scrollbar")
--     -- use 'rstacruz/vim-closer'
--     use({ "nvim-lualine/lualine.nvim", requires = { "nvim-tree/nvim-web-devicons", opt = true } })
--     use({ "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" })
--     use("akinsho/bufferline.nvim")
--     use("norcalli/nvim-colorizer.lua")
--
--     use({ "nvim-telescope/telescope.nvim", tag = "0.1.0", requires = { "nvim-lua/plenary.nvim" } })
--
--     use("sidebar-nvim/sidebar.nvim")
--     use({ "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" } })
--
--     use("jose-elias-alvarez/null-ls.nvim")
--
--     use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client
--     use("williamboman/mason.nvim")
--     use("williamboman/mason-lspconfig.nvim")
--
--     use("hrsh7th/nvim-cmp")
--     use("hrsh7th/cmp-buffer")
--     use("hrsh7th/cmp-cmdline")
--     use("hrsh7th/cmp-nvim-lsp")
--     use("hrsh7th/cmp-nvim-lsp-signature-help")
--     use("hrsh7th/cmp-nvim-lsp-document-symbol")
--     use("hrsh7th/cmp-path")
--     use("hrsh7th/cmp-calc")
--     use("hrsh7th/cmp-emoji")
--
--     use("dcampos/nvim-snippy")
--     use("dcampos/cmp-snippy")
--
--     use("nvim-lua/plenary.nvim")
--
--     use("onsails/lspkind-nvim")
--
--     use({ "j-hui/fidget.nvim", tag = "legacy" })
--
--     use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
--     use("andymass/vim-matchup")
--     use("RRethy/nvim-treesitter-endwise")
--     use("RRethy/vim-illuminate")
--     use("p00f/nvim-ts-rainbow")
--     use("windwp/nvim-autopairs")
--
--     use("unblevable/quick-scope")
-- end)
