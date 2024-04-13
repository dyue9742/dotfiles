return {

    {
        "lifepillar/vim-gruvbox8",
        config = function()
            vim.cmd [[let g:gruvbox_italicize_strings = 0]]
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({})
        end,
    },
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").create_default_mappings()
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
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
                indent = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                }
            })
        end
    },

    -- "mg979/vim-visual-multi",

    "junegunn/fzf",
    "junegunn/vim-easy-align",

    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
}
