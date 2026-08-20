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

-- Bootstrap lazy.nvim
local lazypath = dataPath .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
    })
end
opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- UI & Themes
    { "rmehri01/onenord.nvim", priority = 1000, config = function() vim.cmd.colorscheme("onenord") end },
    { "ellisonleao/gruvbox.nvim" },
    { "nvim-lualine/lualine.nvim", opts = {} },
    { "nvim-mini/mini.icons", config = function()
        require("mini.icons").setup()
        require("mini.icons").mock_nvim_web_devicons()
    end },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    { "nvim-focus/focus.nvim", opts = {} },
    { "nxhung2304/lastplace.nvim", opts = {} },
    { "kevinhwang91/nvim-hlslens", opts = {} },
    { "nvim-lua/plenary.nvim" },

    -- Telescope
    { "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-telescope/telescope-file-browser.nvim" },
      keys = {
          { "<Leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
          { "<Leader>f", function()
              local builtin = require("telescope.builtin")
              if not pcall(builtin.git_files) then builtin.find_files() end
          end, desc = "Find Files" },
      },
      config = function()
          require("telescope").setup{}
          require("telescope").load_extension("file_browser")
      end
    },

    -- Navigation & Editing
    { "smoka7/hop.nvim",
      keys = { { "<leader><leader>", "<cmd>HopWord<cr>", desc = "Hop Word" } },
      opts = {}
    },
    { "nvim-mini/mini.cursorword", opts = {} },
    { "nvim-mini/mini.surround", opts = {} },
    { "nvim-tree/nvim-tree.lua",
      keys = { { "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Tree" } },
      opts = {}
    },

    -- LSP & Completion
    { "neovim/nvim-lspconfig", config = function()
        vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
        vim.lsp.enable({"clangd", "cmake", "pylsp"})
    end },
    { "hrsh7th/nvim-cmp",
      dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-cmdline",
          "hrsh7th/cmp-nvim-lsp-signature-help",
          "quangnguyen30192/cmp-nvim-ultisnips",
      },
      config = function()
          local cmp = require("cmp")
          cmp.setup({
              snippet = { expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end },
              mapping = cmp.mapping.preset.insert({
                  ["<C-p>"] = cmp.mapping.select_prev_item(),
                  ["<C-n>"] = cmp.mapping.select_next_item(),
                  ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                  ["<C-f>"] = cmp.mapping.scroll_docs(4),
                  ["<C-Space>"] = cmp.mapping.complete(),
                  ["<C-e>"] = cmp.mapping.close(),
                  ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
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
          cmp.setup.filetype("gitcommit", { sources = cmp.config.sources({{ name = "buffer" }}) })
          cmp.setup.cmdline("/", { mapping = cmp.mapping.preset.cmdline(), sources = {{ name = "buffer" }} })
          cmp.setup.cmdline(":", {
              mapping = cmp.mapping.preset.cmdline(),
              sources = cmp.config.sources({{ name = "path" }}, {{ name = "cmdline" }})
          })
      end
    },
    { "SirVer/ultisnips" },
    { "honza/vim-snippets" },

    -- Programming
    { "dense-analysis/ale" },
    { "tpope/vim-fugitive",
      keys = {
          { "<leader>gs", "<cmd>Git<cr>", desc = "Git" },
          { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
      }
    },
    { "lewis6991/gitsigns.nvim", opts = {} },
    { "stevearc/conform.nvim", opts = {
        formatters_by_ft = {
            ["_"] = { "trim_whitespace" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            python = { "ruff_format", "ruff_organize_imports" },
        },
        format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
    }},
    { "windwp/nvim-autopairs", opts = {} },
}, { checker = { enabled = false } })

-- UI
require("vim._core.ui2").enable()
opt.background = "dark"
vim.diagnostic.config({ virtual_text = true })

-- Plugin settings
vim.g.ale_use_neovim_diagnostics_api = 1
vim.g.ale_disable_lsp = 1
vim.g.ale_lint_on_text_changed = "normal"
vim.g.ale_lint_on_insert_leave = 1
vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"

vim.cmd("packadd nvim.undotree")
vim.keymap.set('n', '<F5>', "<cmd>Undotree<cr>", { silent = true })
