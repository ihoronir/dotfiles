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

    "neovim/nvim-lspconfig",
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
}
