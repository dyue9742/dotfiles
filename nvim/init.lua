vim.o.ch = 2
vim.o.ph = 10
vim.o.ai = true
vim.o.et = true
vim.o.ts = 4
vim.o.sr = false
vim.o.shiftwidth = 4

vim.o.nu = true
vim.o.rnu = true
vim.o.cul = true

vim.o.nobk = true
vim.o.nosf = true
vim.o.novb = true
vim.o.nowb = true
vim.o.nowrap = true
vim.o.hidden = true

vim.cmd.highlight({ 'LineNrAbove', 'ctermfg=darkgrey' })
vim.cmd.highlight({ 'LineNrBelow', 'ctermfg=darkgrey' })


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

require("lazy").setup("plugins")
require("keymaps")


local servers = { "als", "gopls", "clangd", "pyright", "tsserver", "solargraph", "rust_analyzer", "raku_navigator" }
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers
})

local lc = require("lspconfig")
local cmp = require("cmp")
local snip = require("luasnip")
cmp.setup({
    snippet = {
        expand = function(args)
            snip.lsp_expand(args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered({
            border = "double",
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None"
        }),
        documentation = cmp.config.window.bordered({
            border = "double",
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None"
        }),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif snip.expand_or_jumpable() then
                snip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif snip.jumpable(-1) then
                snip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
})

local capa = require("cmp_nvim_lsp").default_capabilities()
for _, lsp in ipairs(servers) do
    -- default
    lc[lsp].setup {
        capabilities = capa
    }
end

-- customize
lc["lua_ls"].setup {
    capabilities = capa,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT"
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            diagnostics = {
                globals = { "vim", "love" },
            },
        },
    },
}


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', 'gR', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gS', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', 'td', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    end,
})


vim.cmd([[colorscheme gruvbox8]])
