-- nvim-config - NeoVim config
--
-- Copyright (C) 2016-2025  offa
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

-- Settings {{
vim.g.mapleader = ","

vim.opt.joinspaces = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolljump = 5
vim.opt.scrolloff = 3
vim.opt.list = true
vim.opt.listchars = { trail = "·", tab = "» ", extends = "#", nbsp = "."}
vim.opt.autochdir = true
vim.opt.virtualedit = "onemore"
vim.opt.history = 1000
vim.opt.spell = true
vim.opt.hidden = true
vim.opt.backup = true
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.mousehide = true
vim.opt.sessionoptions = "blank,buffers,curdir,folds,tabpages,winsize"
-- }}

-- Directories {{
local dataPath = vim.fn.stdpath("data")
vim.opt.undodir = dataPath .. "/undo"
vim.opt.backupdir = dataPath .. "/backup"
vim.opt.directory = dataPath .. "/swap"
vim.opt.viewdir = dataPath .. "/views"
-- }}


-- Plugins {{
local Plug = vim.fn["plug#"]
vim.call("plug#begin", dataPath .. "/plugged")

-- General
Plug "ellisonleao/gruvbox.nvim"
Plug "nvim-lualine/lualine.nvim"
Plug "nvim-tree/nvim-web-devicons"
Plug "lukas-reineke/indent-blankline.nvim"
Plug "roman/golden-ratio"
Plug "jeetsukumaran/vim-buffergator"
Plug "farmergreg/vim-lastplace"
Plug "kevinhwang91/nvim-hlslens"
Plug "nvim-lua/plenary.nvim"
Plug "nvim-telescope/telescope.nvim"
Plug "nvim-telescope/telescope-file-browser.nvim"
Plug "simnalamburt/vim-mundo"
Plug "smoka7/hop.nvim"
Plug "luochen1990/rainbow"
Plug "RRethy/vim-illuminate"
Plug "ur4ltz/surround.nvim"
Plug "nvim-tree/nvim-tree.lua"

-- Completion
Plug "neovim/nvim-lspconfig"
Plug "hrsh7th/nvim-cmp"
Plug "hrsh7th/cmp-nvim-lsp"
Plug "hrsh7th/cmp-buffer"
Plug "hrsh7th/cmp-path"
Plug "hrsh7th/cmp-cmdline"
Plug "hrsh7th/cmp-nvim-lsp-signature-help"
Plug "SirVer/ultisnips"
Plug "honza/vim-snippets"
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

-- Programming
Plug "dense-analysis/ale"
Plug "tpope/vim-fugitive"
Plug "lewis6991/gitsigns.nvim"
Plug "rhysd/vim-lsp-ale"
Plug "sbdchd/neoformat"
Plug "sheerun/vim-polyglot"
Plug "numToStr/Comment.nvim"
Plug "windwp/nvim-autopairs"

vim.call("plug#end")
-- }}


-- Theme {{
vim.opt.background = "dark"
vim.cmd([[colorscheme gruvbox]])
-- }}


-- Plugin Settings {{
require("lualine").setup{}
require("Comment").setup{}
require("ibl").setup{}
require("gitsigns").setup{}
require("nvim-autopairs").setup{}
require("surround").setup{}
require("nvim-tree").setup{}
require("hlslens").setup{}

-- nvim-cmp
local cmp = require("cmp")
cmp.setup({
        snippet = {
            expand = function(args)
                vim.fn["UltiSnips#Anon"](args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
            }),
        sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "ultisnips" },
                { name = "nvim_lsp_signature_help" }
            }, {
                { name = "buffer" },
            })
    })

-- Set configuration for specific file type
cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
                { name = "buffer" },
            })
    })

-- Use buffer source for `/`
cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" }
        }
    })

-- Use cmdline & path source for ":"
cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
                { name = "path" }
            }, {
                { name = "cmdline" }
            })
    })

-- Setup LSP
vim.lsp.set_log_level("off")

local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.enable("clangd", {capabilities = capabilities})
vim.lsp.enable("cmake", {capabilities = capabilities})
vim.lsp.enable("pylsp", {capabilities = capabilities})

-- ALE
local ale_cpp_std = "-std=c++23"
vim.g.ale_c_cc_options = "-Wall -Wextra -Wpedantic"
vim.g.ale_c_cppcheck_options = "--enable=style --suppress=syntaxError"
vim.g.ale_cpp_cc_options = ale_cpp_std .. " " .. vim.g.ale_c_cc_options
vim.g.ale_cpp_clangtidy_extra_options = vim.g.ale_cpp_cc_options
vim.g.ale_cpp_cppcheck_options = vim.g.ale_c_cppcheck_options
vim.g.ale_cpp_clangcheck_options = "-extra-arg=" .. ale_cpp_std
vim.g.ale_cpp_clangd_options = vim.g.ale_cpp_cc_options
vim.g.ale_use_neovim_diagnostics_api = 1

-- Fugitive
vim.api.nvim_set_keymap("n", "<leader>gs", ":Git<CR>", { noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>gc", ":Git commit<CR>", { noremap = true, silent = true})

-- Lastplace
vim.g.lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"

-- Mundo
vim.api.nvim_set_keymap("n", "<F5>", ":MundoToggle<CR>", { noremap = true, silent = true })

-- Hop
require("hop").setup{}
vim.api.nvim_set_keymap("", "<leader><leader>", ":HopWord<CR>", { noremap = true, silent = true })

-- Telescope
require("telescope").setup{}
require("telescope").load_extension("file_browser")
vim.api.nvim_set_keymap("n", "<Leader>f", "", {
    noremap = true,
    silent = true,
    callback = function()
        local opts = {}
        local ok = pcall(require("telescope.builtin").git_files, opts)
        if not ok then require("telescope.builtin").find_files(opts) end
    end
})

-- Nvim-Tree
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", { noremap = true, silent = true })
-- }}
