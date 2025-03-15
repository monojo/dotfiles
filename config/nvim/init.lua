vim.g.mapleader = ','
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4 -- tab -> spaces
vim.opt.tabstop = 4 -- tab -> spaces visually
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.backup = true
vim.opt.backupdir = os.getenv('HOME') .. '/.cache/nvim/backup//'
vim.opt.directory = os.getenv('HOME') .. '/.cache/nvim/swap//'
vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. '/.cache/nvim/undo//'
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.clipboard = "unnamedplus" -- necessary for tmux cp buffer mirror
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- clear highlight of search
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local stl = {
    '%#ColorColumn#%2f',          -- buffer number
    ' ',                          -- separator
    '%<',                         -- truncate here
    '%*»',                        -- separator
    '%*»',                        -- separator
    '%#DiffText#%m',              -- modified flag
    '%r',                         -- readonly flag
    '%*»',                        -- separator
    '%#CursorLine#(%l/%L,%c)%*»', -- line no./no. of lines,col no.
    '%=«',                        -- right align the rest
    --  '%#Cursor#%02B',              -- value of current char in hex
    --  '%*«',                        -- separator
    --  '%#ErrorMsg#%o',              -- byte offset
    --  '%*«',                        -- separator
    '%#Title#%y',                 -- filetype
    '%*«',                        -- separator
    '%#ModeMsg#%3p%%',            -- % through file in lines
    '%*',                         -- restore normal highlight
}
vim.opt.statusline = table.concat(stl)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        -- Color
        {
            'projekt0n/github-nvim-theme',
            name = 'github-theme',
            lazy = false, -- make sure we load this during startup if it is your main colorscheme
            priority = 1000, -- make sure to load this before all the other start plugins
            config = function()
                require('github-theme').setup({
                    -- ...
                })

                vim.cmd('colorscheme github_light')
            end,
        },
        {'dracula/vim'},
        -- Finder
        { "junegunn/fzf", build = function() vim.fn["fzf#install"]() end , cmd = "FZF"},
        -- { "junegunn/fzf.vim"},
        {
            "ibhagwan/fzf-lua",
            cmd = "FzfLua",
            -- optional for icon support
            -- dependencies = { "nvim-tree/nvim-web-devicons" },
            -- or if using mini.icons/mini.nvim
            -- dependencies = { "echasnovski/mini.icons" },
            opts = {}
        },
        -- Tmux
        { "christoomey/vim-tmux-navigator", event = "VeryLazy"}, -- Seamless navigation between Neovim & tmux
        -- Motion
        { "smoka7/hop.nvim", opts = {keys = 'etovxqpdygfblzhckisuran'}},
        -- Misc
        { "t9md/vim-quickhl"},
        -- Commneter
        { "numToStr/Comment.nvim", config = function()
            require("Comment").setup({
                toggler = {
                    ---Line-comment toggle keymap
                    line = '<Leader>cc',
                    ---Block-comment toggle keymap
                    block = '<Leader>cb',
                },
                opleader = {
                    ---Line-comment keymap
                    line = '<Leader>cc',
                    ---Block-comment keymap
                    block = '<Leader>cb',
                },
                mappings = {
                    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                    basic = true,
                    ---Extra mapping; `gco`, `gcO`, `gcA`
                    extra = false,
                },
            })
        end},
        -- Mark signs
        {"chentoast/marks.nvim",
            config =  true,
        },
        -- Git support
        {"lewis6991/gitsigns.nvim",
            name = 'gitsigns',
            config = true,
            event = "BufReadPre",},
        {"NeogitOrg/neogit",
            dependencies = { "nvim-lua/plenary.nvim"},
            config = true,
            cmd = "Neogit",
        },
        {'tpope/vim-fugitive'},
        {'tpope/vim-rhubarb'}, -- github
        -- LSP
        {"neovim/nvim-lspconfig", -- Core LSP plugin
            "williamboman/mason.nvim",  -- Manages LSP servers
            "williamboman/mason-lspconfig.nvim",  -- Bridges Mason and LSPconfig
            "hrsh7th/nvim-cmp",  -- Autocompletion
            "hrsh7th/cmp-nvim-lsp",  -- LSP completion source
        },
        -- Treesitter
        {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
        'nvim-treesitter/nvim-treesitter-textobjects',
        {
            "nvim-telescope/telescope.nvim",
            dependencies = { "nvim-lua/plenary.nvim" }
        },
        {'ranjithshegde/ccls.nvim'},
        'L3MON4D3/luasnip',
        'ThePrimeagen/harpoon',
        'MattesGroeger/vim-bookmarks',
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = function()
                require("nvim-autopairs").setup({
                    check_ts = true,  -- Enable Treesitter integration
                    fast_wrap = {},   -- Enable fast wrap feature
                    disable_filetype = { "TelescopePrompt", "vim" }
                })

                -- Integrate with nvim-cmp (if you're using it)
                local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                local cmp = require("cmp")
                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end
        },
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            opts = {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            },
            keys = {
                {
                    "<leader>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "Buffer Local Keymaps (which-key)",
                },
            },
        },
        { "max397574/better-escape.nvim", config = true, }
    } --end of spec
})

vim.api.nvim_create_autocmd('BufLeave', {
    pattern = '*',
    callback = function()
        if vim.fn.getbufvar(vim.fn.bufnr('%'), '&buftype') == 'quickfix' then
            vim.cmd('cclose')
        end
    end
})
-- Mason for external tools management
-- It does not support ccls
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright"}, -- Replace with needed LSPs
    automatic_installation = true,
})

require("ccls").setup()

require('fzf-lua').setup({
    fzf_colors = {
        -- This changes the background color of the currently selected line
        ["bg+"] = { "bg", "CursorLine" },
        -- This changes the foreground (text) color of the currently selected line
        ["fg+"] = { "fg", "Normal" },
        -- This changes the highlight color for matching text in the selected line
        ["hl+"] = { "fg", "Statement" },
    }
})

local lspconfig = require("lspconfig")
-- Function to attach LSP keybindings
local on_attach = function(client, bufnr)
    -- local opts = { noremap = true, silent = true, buffer = bufnr }
    local function map(mode, lhs, rhs, opts)
        local options = {noremap = true, silent = true}
        if opts then
            if type(opts) == 'string' then
                opts = {desc = opts}
            end
            options = vim.tbl_extend('force', options, opts)
        end
        if type(opts) == 'string' then
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
        else
            vim.keymap.set(mode, lhs, rhs, {buffer=true})
        end
    end
    local function nmap(lhs, rhs, opts)
        map('n', lhs, rhs, opts)
    end

    -- local function buf_set_option(name, value) vim.api.nvim_set_option_value(name, value, {scope='local'}) end

    -- Enable completion triggered by <c-x><c-o>
    -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local telescope = require("telescope.builtin")

    --   vim.lsp.buf.references(nil, {
    --   includeDeclaration = false,
    --   includeDefinition = false
    -- })

    -- nmap('<leader>s', '<cmd>Telescope lsp_document_symbols<cr>')


    -- vim.keymap.set("n", "<leader>d", telescope.lsp_definitions, { noremap = true, silent = true })
    -- vim.keymap.set("n", "<leader>r", telescope.lsp_references, { noremap = true, silent = true })
    -- vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition)
    -- vim.keymap.set("n", "<leader>r", vim.lsp.buf.references)

    -- nmap(',f', '<cmd>lua require("ccls.protocol").request("textDocument/references",{excludeRole=32})<cr>') -- not call
    -- nmap(',m', '<cmd>lua require("ccls.protocol").request("textDocument/references",{role=64})<cr>') -- macro
    --   vim.keymap.set("n", ",f", function()
    --   require("ccls.protocol").request("textDocument/references", { excludeRole = 32 })
    -- end, { noremap = true, silent = true })
    -- nmap(',r', '<cmd>lua require("ccls.protocol").request("textDocument/references",{role=4})<cr>') -- read
    -- nmap(',m', '<cmd>lua require("ccls.protocol").request("textDocument/references",{role=8})<cr>') -- read
    -- nmap(',w', '<cmd>lua require("ccls.protocol").request("textDocument/references",{role=16})<cr>') -- write

    -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    --   vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    --
  --[[ vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

  --  Hover & Signature Help
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts)

  --  Workspace Management
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)

  --  Code Actions & Rename
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

  --  Diagnostics
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

  --  Format Document
  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts) ]]

    -- Turn off treesitter when lsp server support semantic token
    if client.server_capabilities.semanticTokensProvider then
        vim.api.nvim_set_hl(0, "@lsp.type.parameter", { italic = true })
        vim.treesitter.stop(bufnr)
    end
end

local servers = { "ccls", "lua_ls", "pyright"}

lspconfig.ccls.setup {
    init_options = {
        cache = {
            directory = ".ccls-cache";
        };
    }
}

for _, lsp in ipairs(servers) do
    local options = {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }
    if lsp == 'ccls' then
        options = vim.tbl_extend('force', options, {
            init_options = {
                index = {
                    threads = 0,
                    initialBlacklist = {"/(test|unittests)/"},
                };
                --   reference = {
                --     excludeRole = {"definition", "declaration"}
                -- },
            }
        })
    end
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })
end

lspconfig.lua_ls.setup {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
            }
        })
    end,
    settings = {
        Lua = {}
    }
}


-- nvim completion
local luasnip = require('luasnip')
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        }),
        -- Enter for next para
        ['<C-j>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ["<C-k>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        {name = "nvim_lua"}, {name = "look"}
    },
})

require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "python", "c", "cpp", "json", "javascript", "bash", "markdown" },
    indent = {enable = true},
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']c'] = '@class.outer',
                [']]'] = '@function.outer',
                [']o'] = '@loop.*',
            },
            goto_next_end = {
                [']C'] = '@class.outer',
            },
            goto_previous_start = {
                ['[c'] = '@class.outer',
                ['[['] = '@function.outer',
                ['[o'] = '@loop.*',
            },
            goto_previous_end = {
                ['[C'] = '@class.outer',
            },
        },
    },
})

-- Mappings
local fzf = require("fzf-lua")
vim.keymap.set("n", "<Space><Space>", function() fzf.files() end, { noremap = true, silent = true })
vim.keymap.set("n", "<Space>b", function() fzf.buffers() end, { noremap = true, silent = true })
vim.keymap.set("n", "<Space>f", function() fzf.live_grep() end, { noremap = true, silent = true })
vim.keymap.set("n", "<Space>w", function() fzf.grep_cword() end, { noremap = true, silent = true })
vim.keymap.set("n", "<Space>g", function() fzf.git_files() end, { noremap = true, silent = true })
vim.keymap.set("n", "<Space>t", function() fzf.treesitter() end, { noremap = true, silent = true })
vim.keymap.set("n", "<Space>c", function() fzf.commands() end, { noremap = true, silent = true })
vim.keymap.set("n", "<Space>s", function() fzf.lsp_document_symbols() end, { noremap = true, silent = true })
vim.keymap.set("n", "gr", function() fzf.lsp_references() end, { noremap = true, silent = true })
vim.keymap.set("n", "gd", function() fzf.lsp_definitions() end, { noremap = true, silent = true })
vim.keymap.set('v', '=', '<cmd>lua vim.lsp.buf.format()<CR>')
vim.api.nvim_create_user_command("F", "FzfLua", {})

-- Motion jumps
local hop = require("hop")
vim.keymap.set('', 's', function() hop.hint_char1({ current_line_only = false }) end, {remap=true})
--hl words
vim.keymap.set("n", "<Leader>h", "<Plug>(quickhl-manual-this)", { noremap = false, silent = true, desc = "Highlight cwd"})
--github link 
vim.keymap.set("n", "<leader>gl", ":.GBrowse!<CR>", { noremap = true, silent = true })

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>ba", function() mark.add_file() end, { desc = "Add file to Harpoon" })
vim.keymap.set("n", "<leader>bb", function() ui.toggle_quick_menu() end, { desc = "Open Harpoon UI" })
vim.keymap.set("n", "<leader>bc", function() mark.clear_all() print("Harpoon marks cleared!") end, { desc = "Clear all Harpoon marks" })
vim.keymap.set("n", "<leader>bh", "<cmd>Telescope harpoon marks<CR>", { desc = "Find Harpoon files with Telescope" })
-- Quickly jump between files (1-4)
vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Go to file 1" })
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Go to file 2" })
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "Go to file 3" })
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "Go to file 4" })

vim.keymap.set("n", "J", vim.lsp.buf.hover, { desc = "Show LSP hover docs" })
vim.keymap.set("n", "K", "<cmd>Man<CR>", { desc = "Show manual" , remap = false})
