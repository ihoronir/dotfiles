-- require("plugins")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

plugins = require("plugins")
require("lazy").setup(plugins)

vim.opt.fenc = "utf-8"

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')
vim.keymap.set("n", "s", '"_s')

vim.keymap.set("n", "<C-n>", "<cmd>bnext<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-p>", "<cmd>bprevious<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-q>", "<cmd>b#<cr><cmd>bd#<cr>", { noremap = true })

-- Appeacance
vim.api.nvim_command([[colorscheme carbonfox]])
vim.opt.number = true
vim.opt.cursorline = true
--set cursorcolumn
--set smartindent
--set visualbell
vim.opt.termguicolors = true
vim.opt.scrolloff = 4
--vim.opt.ignorecase = true
--vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- NvimTree
vim.keymap.set("n", "<C-e>", "<cmd>NvimTreeToggle<CR>", { silent = true })
vim.keymap.set("n", "0", "^")
vim.keymap.set("n", "^", "0", { silent = true })

local navic = require("nvim-navic")
navic.setup({
    lsp = {
        auto_attach = true,
    },
    highlight = true,
})
require("lualine").setup({
    sections = {
        lualine_c = {
            { navic.get_location, cond = navic.is_available },
        },
    },
})

require("colorizer").setup()

require("ibl").setup({
    indent = {
        char = "▏",
    },
    scope = {
        enabled = false,
    },
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

require("bufferline").setup({
    options = {
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = false,
    },
})

require("nvim-tree").setup()

require("sidebar-nvim").setup()

require("scrollbar").setup()

require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "lua", "json", "rust", "javascript", "html" },
    --sync_install = false,
    highlight = {
        enable = true,
    },
    matchup = {
        enable = true,
    },
    endwise = {
        enable = true,
    },
})
require("nvim-autopairs").setup()

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.rustfmt.with({
            extra_args = function(params)
                local Path = require("plenary.path")
                local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

                if cargo_toml:exists() and cargo_toml:is_file() then
                    for _, line in ipairs(cargo_toml:readlines()) do
                        local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
                        if edition then
                            return { "--edition=" .. edition }
                        end
                    end
                end
                -- default edition when we don't find `Cargo.toml` or the `edition` in it.
                return { "--edition=2021" }
            end,
        }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    -- vim.lsp.buf.formatting_sync()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

require("mason").setup()

local lspconfig_setup = function(server_name)
    local opts = {
        on_attach = function(client, bufnr)
            local bufopts = { silent = true, buffer = bufnr }
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
            vim.keymap.set("n", "gtD", vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set("n", "grf", vim.lsp.buf.references, bufopts)
            vim.keymap.set("n", "<space>p", vim.lsp.buf.format, bufopts)
        end,
        capabilities = capabilities,
    }

    if server_name == "sumneko_lua" then
        opts.settings = {
            Lua = {
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim" },
                },
            },
        }
    end

    if server_name == "clangd" then
        opts.settings = {
            cmd = {},
        }
    end

    lspconfig[server_name].setup(opts)
end

mason_lspconfig.setup_handlers({ lspconfig_setup })

for _, lsp in ipairs({ "clangd", "rust_analyzer", "texlab", "typst_lsp" }) do
    lspconfig_setup(lsp)
end

require("fidget").setup({})

-- nvim-cmp setup
local cmp = require("cmp")

cmp.setup({
    -- REQUIRED - you must specify a snippet engine
    snippet = {
        expand = function(args)
            require("snippy").expand_snippet(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "snippy" },
        { name = "path" },
        { name = "calc" },
        { name = "emoji" },
    }, {
        { name = "buffer" },
    }),
})

-- If you want insert `(` after select function or method item
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "nvim_lsp_document_symbol" },
    }, {
        { name = "buffer" },
    }),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

local lspkind = require("lspkind")
cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text", -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
                -- ...
                return vim_item
            end,
        }),
    },
})
