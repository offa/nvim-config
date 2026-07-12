-- nvim-config - NeoVim config
--
-- Copyright (C) 2016-2026  offa
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
vim.loader.enable()

vim.g.mapleader = ","

local dataPath = vim.fn.stdpath("data")

-- Options
local opt = vim.opt
opt.joinspaces = false
opt.splitright = true
opt.splitbelow = true
opt.number = true
opt.wrap = false
opt.autoindent = true
opt.shiftwidth = 4
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.termguicolors = true
opt.cursorline = true
opt.showcmd = true
opt.showmode = true
opt.showmatch = true
opt.signcolumn = "yes"
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 6
opt.list = true
opt.listchars = { trail = "·", tab = "» ", extends = "#", nbsp = "."}
opt.autochdir = true
opt.virtualedit = "onemore"
opt.history = 1000
opt.spell = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.mousehide = true
opt.sessionoptions = "blank,buffers,curdir,folds,tabpages,winsize"
opt.updatetime = 300
opt.undodir = dataPath .. "/undo"
opt.viewdir = dataPath .. "/views"
-- }}

-- Plugins {{
local Plug = vim.fn["plug#"]
vim.call("plug#begin", dataPath .. "/plugged")

-- General
Plug "ellisonleao/gruvbox.nvim"
Plug "nvim-lualine/lualine.nvim"
Plug "nvim-mini/mini.icons"
Plug "lukas-reineke/indent-blankline.nvim"
Plug "nvim-focus/focus.nvim"
Plug "nxhung2304/lastplace.nvim"
Plug "kevinhwang91/nvim-hlslens"
Plug "nvim-lua/plenary.nvim"
Plug "nvim-telescope/telescope.nvim"
Plug "nvim-telescope/telescope-file-browser.nvim"
Plug "smoka7/hop.nvim"
Plug "nvim-mini/mini.cursorword"
Plug "nvim-mini/mini.surround"
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
Plug "quangnguyen30192/cmp-nvim-ultisnips"
Plug "honza/vim-snippets"

-- Programming
Plug "dense-analysis/ale"
Plug "tpope/vim-fugitive"
Plug "lewis6991/gitsigns.nvim"
Plug "stevearc/conform.nvim"
Plug "windwp/nvim-autopairs"

vim.call("plug#end")
-- }}


-- UI {{
require("vim._core.ui2").enable()

vim.opt.background = "dark"
vim.cmd([[colorscheme gruvbox]])
vim.diagnostic.config({ virtual_text = true })
-- }}


-- Plugin Settings {{
require("lualine").setup{}
require("ibl").setup{}
require("gitsigns").setup{}
require("nvim-autopairs").setup{}
require('mini.surround').setup()
require("nvim-tree").setup{}
require("hlslens").setup{}
require("mini.icons").setup()
require("lastplace").setup{}
require("focus").setup{}
require('mini.cursorword').setup{}

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
    sources = cmp.config.sources({{ name = "buffer" }})
})

-- Use buffer source for `/`
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{ name = "buffer" }}
})

-- Use cmdline & path source for ":"
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{ name = "path" }}, {{ name = "cmdline" }})
})

-- Setup LSP
vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
vim.lsp.enable({"clangd", "cmake", "pylsp"})
vim.lsp.log.set_level("off")

-- ALE
vim.g.ale_use_neovim_diagnostics_api = 1
vim.g.ale_disable_lsp = 1
vim.g.ale_lint_on_text_changed = "normal"
vim.g.ale_lint_on_insert_leave = 1

-- Fugitive
vim.keymap.set("n", "<leader>gs", ":Git<CR>", { noremap = true, silent = true})
vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { noremap = true, silent = true})

-- Hop
require("hop").setup{}
vim.keymap.set("", "<leader><leader>", ":HopWord<CR>", { noremap = true, silent = true })

-- Telescope
local telescope = require("telescope")
telescope.setup{}
telescope.load_extension("file_browser")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader>b", builtin.buffers, { silent = true })
vim.keymap.set("n", "<Leader>f", function()
    if not pcall(builtin.git_files) then builtin.find_files() end
end, { silent = true })

-- Nvim-Tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", { noremap = true, silent = true })

-- UltiSnips
vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"

-- Mini Icons
require("mini.icons").mock_nvim_web_devicons()

-- Undo
vim.cmd("packadd nvim.undotree")
vim.keymap.set('n', '<F5>', function() vim.cmd("Undotree") end, { noremap = true, silent = true })

-- Conform
require("conform").setup({
    formatters_by_ft = {
        ["_"] = { "trim_whitespace" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        python = { "ruff_format", "ruff_organize_imports" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})
-- }}
