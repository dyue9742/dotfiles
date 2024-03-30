filetype plugin on
syntax enable

set encoding=utf-8
set fileencoding=utf-8

set shiftwidth=2
set shiftround
set tabstop=2

set mouse=a

set nu rnu

set cursorline
set autoindent
set ignorecase
set expandtab
set incsearch
set hlsearch
set wildmenu

set signcolumn=yes:1
set colorcolumn=80
set formatoptions=rq

set scrolloff=8
set cmdheight=2
set pumheight=10
set sidescrolloff=4

set nowrap
set nobackup
set noswapfile
set noerrorbells
set novisualbell
set nowritebackup

call plug#begin()
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'folke/trouble.nvim'

Plug 'junegunn/fzf', {'do': {->fzf#install()}}
Plug 'ggandor/leap.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

lua << END

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

local cmp = require'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local capabilities = require'cmp_nvim_lsp'.default_capabilities()

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set('n', 'gH', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', 'tD', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', function ()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
end

require'mason'.setup()

require'mason-lspconfig'.setup({
  ensure_installed = {
    "kotlin_language_server",
    "rust_analyzer",
    "clojure_lsp",
    "solargraph",
    "tsserver",
    "pyright",
    "lua_ls",
    "clangd",
    "cmake",
    "gopls",
    "jdtls",
    "hls",
    "als",
  }
})

require'mason-lspconfig'.setup_handlers {
  ["als"] = function (...)
    require'lspconfig'.als.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        ada = {
          projectFile = "project.gpr";
          scenarioVariables = { ... };
        }
      }
    }
  end,
  ["hls"] = function ()
    require'lspconfig'.hls.setup {
      filetypes = { "haskell", "lhaskell", "cabal" },
    }
  end,
  ["cmake"] = function ()
    require'lspconfig'.cmake.setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
  ["gopls"] = function ()
    require'lspconfig'.gopls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
        }
      }
    }
  end,
  ["lua_ls"] = function ()
    require'lspconfig'.lua_ls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
          return
        end
        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT'
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.run.VIMRUNTIME
            }
          }
        })
      end,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "love" }
          }
        }
      }
    }
  end,
  ["clangd"] = function ()
    require'lspconfig'.clangd.setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
  ["pyright"] = function ()
    require'lspconfig'.pyright.setup {
      on_attach = on_attach,
      capabilities = capabilities,

    }
  end,
  ["tsserver"] = function ()
    require'lspconfig'.tsserver.setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
  ["solargraph"] = function ()
    require'lspconfig'.solargraph.setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
  ["rust_analyzer"] = function ()
    require'lspconfig'.rust_analyzer.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            enable = false;
          }
        }
      }
    }
  end,
}

require'nvim-treesitter.configs'.setup{
  ensure_installed = {
    "c",
    "r",
    "go",
    "ada",
    "asm",
    "cpp",
    "lua",
    "sql",
    "tsx",
    "vim",
    "cuda",
    "html",
    "java",
    "json",
    "make",
    "objc",
    "perl",
    "ruby",
    "rust",
    "toml",
    "yaml",
    "cmake",
    "ocaml",
    "regex",
    "scala",
    "erlang",
    "kotlin",
    "groovy",
    "python",
    "haskell",
    "dockerfile",
    "javascript",
    "typescript",
  },
  indent = { enable = true },
  highlight = { enable = true },
}

require'lualine'.setup{}

require'leap'.create_default_mappings()

END

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_layout = { 'down': '60%' }
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

autocmd BufWritePre * :%s/\s\+$//e

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>

nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
nnoremap bs :ls<CR>

nnoremap <leader>p :echo expand('%:p')<CR>

colorscheme catppuccin-mocha
