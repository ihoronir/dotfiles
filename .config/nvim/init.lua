require('plugins')

vim.opt.fenc='utf-8'

vim.opt.tabstop=4
vim.opt.shiftwidth=4

-- Appeacance
vim.api.nvim_command [[colorscheme carbonfox]]
vim.opt.number=true
vim.opt.cursorline=true
--set cursorcolumn
--set smartindent
--set visualbell
vim.opt.termguicolors=true

--" NvimTree
vim.keymap.set('n', '<C-e>', '<cmd>NvimTreeToggle<CR>', {silent = true})
vim.keymap.set('n', '0', '^')
vim.keymap.set('n', '^', '0', {silent = true})
--nnoremap <silent><C-e> :NvimTreeToggle<CR>
--"nnoremap <silent><C-e> :Neotree<CR>
--
--" rust.vim
--vim.g.syntax=false
-- vim.cmd('syntax off')
vim.g.rustfmt_autosave=0

--require('rust.vim').setup()

vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' };
vim.cmd("highlight QuickScopePrimary guifg='#afff5f' gui=inverse ctermfg=155 cterm=underline")
vim.cmd("highlight QuickScopeSecondary guifg='#5fffff' gui=inverse ctermfg=81 cterm=underline")

local navic = require('nvim-navic');
require('lualine').setup {
	sections = {
		lualine_c = {
			{ navic.get_location, cond = navic.is_available },
		}
	}
}

require('colorizer').setup()

require('indent_blankline').setup()

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('bufferline').setup {
	options = {
		diagnostics = "nvim_lsp",
		show_buffer_close_icons = false,
	}
};

require("nvim-tree").setup()

require('sidebar-nvim').setup()

require('neo-tree').setup()

require("scrollbar").setup()

require('nvim-treesitter.configs').setup {
	ensure_installed = "all",
	highlight = {
		enable = true,
		--disable = { "rust" },
	},
	matchup = {
		enable = true,
	},
	endwise = {
		enable = true,
	},
}
require("nvim-autopairs").setup()

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		--null_ls.builtins.formatting.clang_format,
	},
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

require("mason").setup()

local lspconfig_setup = function(server_name)
	local opts = {
		on_attach = function(client, bufnr)
			--local bufopts = { silent = true, buffer = bufnr }
			--vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
			--vim.keymap.set('n', 'gtD', vim.lsp.buf.type_definition, bufopts)
			--vim.keymap.set('n', 'grf', vim.lsp.buf.references, bufopts)
			--vim.keymap.set('n', '<space>p', vim.lsp.buf.format, bufopts)

			if client.server_capabilities.documentSymbolProvider then
				navic.attach(client, bufnr)
			end
		end,
		capabilities = capabilities,
	}

	if server_name == 'sumneko_lua' then
		opts.settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = {'vim'},
				},
			},
		};
	end

	lspconfig[server_name].setup(opts)
end

mason_lspconfig.setup_handlers({ lspconfig_setup })

local servers = { 'clangd', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
	lspconfig_setup(lsp);
end

require"fidget".setup{}

-- nvim-cmp setup
local cmp = require 'cmp'

cmp.setup({
	-- REQUIRED - you must specify a snippet engine
	snippet = {
		expand = function(args)
			require('snippy').expand_snippet(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'snippy' },
		{ name = 'path' },
		{ name = 'calc' },
		{ name = 'emoji' },
	}, {
		{ name= 'buffer' },
	})
})

-- If you want insert `(` after select function or method item
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp_document_symbol' }
	}, {
		{ name = 'buffer' }
	})
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})


local lspkind = require('lspkind')
cmp.setup {
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol_text', -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function (entry, vim_item)
				-- ...
				return vim_item
			end
		})
	}
}
