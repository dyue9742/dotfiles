call plug#begin()
" THEMES
Plug 'folke/tokyonight.nvim'

" TOOLS
Plug 'smoka7/hydra.nvim'
Plug 'smoka7/multicursors.nvim'
Plug 'psf/black', {'branch': 'stable'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'echasnovski/mini.nvim', {'branch': 'stable'}
Plug 'ggandor/leap.nvim'
Plug 'folke/trouble.nvim'
Plug 'folke/which-key.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP
Plug 'L3MON4D3/LuaSnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" UI
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
call plug#end()

lua <<EOF
require 'autoload.option'

require'mini.pairs'.setup {
	mappings = {
		["'"] = false,
	},
}

require'mini.ai'.setup {}

require'multicursors'.setup {
-- <Esc>     | Returns to multicursor normal mode
-- <C-c>     | Returns to multicursor normal mode
-- <BS>      | Deletes the char before the selections
-- <Del>     | Deletes the char under the selections
-- <Left>    | Moves the selections one char Left
-- <Up>      | Moves the selections one line Up
-- <Right>   | Moves the selections one char Right
-- <Down>    | Moves the selections one line Down
-- <C-Left>  | Moves the selections one word Left
-- <C-Right> | Moves the selections one word Right
-- <Home>    | Moves the selections to start of line
-- <End>     | Moves the selections to end of line
-- <CR>      | Insert one line below the selections
-- <C-j>     | Insert one line below the selections
-- <C-v>     | Pastes the text from system clipboard
-- <C-r>     | Insert the contents of a register
-- <C-w>     | Deletes one word before the selections
-- <C-BS>    | Deletes one word before the selections
-- <C-u>     | Deletes from the start of selections till the start of line
	hint_config = false,
}

require'ibl'.setup {}

require'leap'.setup {}

require'lualine'.setup {
	options = {
		icons_enabled = true,
		theme = 'tokyonight',
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {
			{'filename', file_status = true, path = 1}
		},
		lualine_x = {'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
	tabline = {
		lualine_a = {'buffers'},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {'tabs'}
	}
}

require'mason'.setup {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
}

local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup {
	sources = {
		{name = 'nvim_lsp'},
		{name = 'luasnip'},
	},
	mapping = cmp.mapping.preset.insert({
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
}

local default_capabilities = require'cmp_nvim_lsp'.default_capabilities()

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
		vim.keymap.set('n', '<leader>[', vim.diagnostic.goto_prev)
		vim.keymap.set('n', '<leader>]', vim.diagnostic.goto_next)
		vim.keymap.set('n', '<leader>f', vim.diagnostic.open_float)
		vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist)
		vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<leader>f', function()
			vim.lsp.buf.format { async = false }
		end, opts)
	end,
})

local ensure_installed_dict = {
	'asm_lsp',
	'awk_ls',
	'lua_ls',
	'hls',
	'cmake',
	'gopls',
	'jdtls',
	'eslint',
	'clangd',
	'pyright',
	'tsserver',
	'opencl_ls',
	'omnisharp',
	'solargraph',
	'rust_analyzer',
}

local handlers = {}

for _, v in pairs(ensure_installed_dict) do
	handlers[v] = function ()
		require'lspconfig'[v].setup {
			capabilities = default_capabilities
		}
	end
end

handlers['lua_ls'] = function ()
	require'lspconfig'['lua_ls'].setup {
		capabilities = default_capabilities,
		settings = {
			Lua = {
				format = {
					enable = true,
					defaultConfig = {
						indent_style = 'space',
						indent_size = '2',
					}
				},
				diagnostics = {
					globals = {'vim', 'love'},
				},
			},
		},
	}
end


require'mason-lspconfig'.setup {
	ensure_installed = ensure_installed_dict,
	handlers = handlers,
}

require'nvim-treesitter.configs'.setup {
	ensure_installed = {
		'c',
		'go',
		'cpp',
		'css',
		'lua',
		'tsx',
		'vim',
		'cuda',
		'fish',
		'json',
		'llvm',
		'make',
		'perl',
		'rust',
		'toml',
		'yaml',
		'cmake',
		'ocaml',
		'regex',
		'scala',
		'swift',
		'erlang',
		'elixir',
		'groovy',
		'haskell',
		'c_sharp',
		'javascript',
		'typescript',
	},
	indent = {
		enable = true
	},
	highlight = {
		enable = true,
	},
}

require'telescope'.setup {
	defaults = {
		mappings = {
			i = {
				["<leader>h"] = "which_key",
			},
		},
	},
}

require'tokyonight'.setup {
	options = {
		style = "night",
		styles = {
			comments = { italic = false },
			keywords = { italic = false },
		},
	},
}

require'trouble'.setup {}

require'which-key'.setup {}
EOF

colorscheme tokyonight

nnoremap <leader>tx <cmd>TroubleToggle<cr>
nnoremap <leader>tl <cmd>TroubleToggle loclist<cr>
nnoremap <leader>tf <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>tr <cmd>TroubleToggle lsp_references<cr>
nnoremap <leader>td <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>tw <cmd>TroubleToggle workspace_diagnostics<cr>

nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>

nnoremap <leader>[b :bprev<CR>
nnoremap <leader>]b :bnext<CR>

augroup black_on_save
	autocmd!
	autocmd BufWritePre *.py Black
augroup end
