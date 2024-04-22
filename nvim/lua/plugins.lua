return {
    --     {
    --         'lifepillar/vim-gruvbox8',
    --         config = function()
    --             vim.cmd [[let g:gruvbox_italicize_strings = 0]]
    --         end,
    --     },

    'NLKNguyen/papercolor-theme',
    {
        'rebelot/kanagawa.nvim',
        config = function()
            require('kanagawa').setup({
                compile = true,
                typeStyle = { bold = true, italic = false },
                keywordStyle = { bold = true, italic = false },
                functionStyle = { bold = true, italic = false },
                statementStyle = { bold = true, italic = false },
                theme = "dragon",
            })
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({})
        end,
    },
    {
        "ggandor/leap.nvim",
        config = function()
            require('leap').setup({
                vim.keymap.set('n', 'l', '<Plug>(leap)'),
                vim.keymap.set('n', 'L', '<Plug>(leap-from-window)'),
                vim.keymap.set({ 'x', 'o' }, 'l', '<Plug>(leap-forward)'),
                vim.keymap.set({ 'x', 'o' }, 'L', '<Plug>(leap-backward)'),
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require('nvim-treesitter.configs').setup({
                modules = {},
                auto_install = true,
                sync_install = true,
                ensure_installed = {
                    "c",
                    "r",
                    "go",
                    "ada",
                    "asm",
                    "cpp",
                    "css",
                    "lua",
                    "sql",
                    "tsx",
                    "vim",
                    "cuda",
                    "java",
                    "json",
                    "html",
                    "objc",
                    "perl",
                    "ruby",
                    "rust",
                    "yaml",
                    "cmake",
                    "ocaml",
                    "query",
                    "regex",
                    "scala",
                    "elixir",
                    "erlang",
                    "python",
                    "kotlin",
                    "haskell",
                    "dockerfile",
                    "javascript",
                    "typescript"
                },
                ignore_install = {},
                indent = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                    disable = function()
                        local name = vim.api.nvim_buf_get_name(0)
                        if string.sub(name, -4) == ".txt" then
                            return true
                        end
                    end
                }
            })
        end
    },

    "mg979/vim-visual-multi",

    'junegunn/fzf',
    'junegunn/vim-easy-align',

    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
}
