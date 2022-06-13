" Modeline and Notes {{
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{,}} foldlevel=0 foldmethod=marker spell:
"
" Copyright 2016-2022 offa
" Copyright 2014 Steve Francia
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.
" }}

" List of options {{
"
    " To override all the included bundles, add the following to your
    " plugins.vim file:
    "   let g:override_spf13_bundles = 1

    " Select plugin groups to use
    "   let g:spf13_bundle_groups = [ ... ]

    " Disable restore cursor to file position of previous editing session
    "   let g:spf13_no_restore_cursor = 1

    " Disable shift key fixes
    "   let g:spf13_no_keyfixes = 1

    " Prevent automatically changing to open file directory
    "   let g:spf13_no_autochdir = 1

    " Leader keys
    "   let g:spf13_leader = '\'
    "   let g:spf13_localleader = '_'

    " Disable easier moving in tabs and windows
    "   let g:spf13_no_easyWindows = 1

    " Disable wrap relative motion for start/end line motions
    "   let g:spf13_no_wrapRelMotion = 1

    " Disable fast tab navigation
    "   let g:spf13_no_fastTabs = 1

    " Clear search highlighting
    "   let g:spf13_clear_search_highlight = 1

" }}

" Environment {{

    " Identify platform {{
        silent function! GUI()
            return has('gui_running')
        endfunction
    " }}

    " Arrow Key Fix {{
        " https://github.com/spf13/spf13-vim/issues/780
        if &term[:4] ==? 'xterm' || &term[:5] ==? 'screen' || &term[:3] ==? 'rxvt'
            inoremap <silent> <C-[>OC <RIGHT>
        endif
    " }}

    " Support optional configurations {{
        silent function! SourceIfAvailable(filename)
            let l:filepath = expand('~/.config/nvim/' . a:filename)
            if filereadable(l:filepath)
                execute 'source ' . l:filepath
            endif
        endfunction()
    " }}

    " Configuration functions {{
        silent function! BundleActive(bundle)
            return count(g:spf13_bundle_groups, a:bundle)
        endfunction

        silent function! PluginActive(plugin)
            return isdirectory(expand('~/.config/nvim/plugged/' . a:plugin))
        endfunction
    " }}

" }}

" Use local before.vim if available {{
    call SourceIfAvailable('before.vim')
" }}

" Plugins {{
    call plug#begin('~/.config/nvim/plugged')

    if !exists('g:spf13_bundle_groups')
        let g:spf13_bundle_groups=['general', 'writing', 'completion', 'programming', 'c_cpp', 'python', ]
    endif

    if !exists('g:override_spf13_bundles')

    " General {
        if BundleActive('general')
            " Themes
            Plug 'joshdick/onedark.vim'
            Plug 'gruvbox-community/gruvbox'

            " Airline
            Plug 'vim-airline/vim-airline'
            Plug 'vim-airline/vim-airline-themes'

            Plug 'raviqqe/vim-nonblank'
            Plug 'roman/golden-ratio'
            Plug 'RRethy/vim-illuminate'
            Plug 'jeetsukumaran/vim-buffergator'
            Plug 'scrooloose/nerdtree'
            Plug 'tpope/vim-surround'
            Plug 'tpope/vim-repeat'
            Plug 'rhysd/conflict-marker.vim'
            Plug 'windwp/nvim-autopairs'
            Plug 'ctrlpvim/ctrlp.vim'
            Plug 'tacahiroy/ctrlp-funky'
            Plug 'terryma/vim-multiple-cursors'
            Plug 'vim-scripts/sessionman.vim'
            Plug 'easymotion/vim-easymotion'
            Plug 'jistr/vim-nerdtree-tabs'
            Plug 'simnalamburt/vim-mundo'
            Plug 'lukas-reineke/indent-blankline.nvim'
            Plug 'vim-scripts/restore_view.vim'
            Plug 'mhinz/vim-signify'
            Plug 'tpope/vim-abolish'
            Plug 'osyo-manga/vim-over'
            Plug 'kana/vim-textobj-user'
            Plug 'kana/vim-textobj-indent'
            Plug 'gcmt/wildfire.vim'
            Plug 'kevinhwang91/nvim-hlslens'
        endif
    " }

    " Writing {
        if BundleActive('writing')
            Plug 'reedes/vim-litecorrect'
            Plug 'reedes/vim-textobj-sentence'
            Plug 'reedes/vim-textobj-quote'
            Plug 'reedes/vim-wordy'
        endif
    " }

    " General Programming {
        if BundleActive('programming')
            Plug 'dense-analysis/ale'
            Plug 'tpope/vim-fugitive'
            Plug 'scrooloose/nerdcommenter'
            Plug 'godlygeek/tabular'
            Plug 'luochen1990/rainbow'
            Plug 'sbdchd/neoformat'
            Plug 'sheerun/vim-polyglot'
            Plug 'alvan/vim-closetag'
            Plug 'neovim/nvim-lspconfig'
            Plug 'rhysd/vim-lsp-ale'
        endif
    " }

    " Snippets & AutoComplete {
        if BundleActive('completion')
            Plug 'hrsh7th/nvim-cmp'
            Plug 'hrsh7th/cmp-nvim-lsp'
            Plug 'hrsh7th/cmp-buffer'
            Plug 'hrsh7th/cmp-path'
            Plug 'hrsh7th/cmp-cmdline'
            Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
            Plug 'SirVer/ultisnips'
            Plug 'honza/vim-snippets'
        endif
    " }

    " C / C++ {
        if BundleActive('c_cpp')
            Plug 'octol/vim-cpp-enhanced-highlight'
        endif
    " }

    " Python {
        if BundleActive('python')
            Plug 'vim-scripts/python_match.vim'
        endif
    " }

    " Javascript {
        if BundleActive('javascript')
            Plug 'elzr/vim-json'
            Plug 'groenewege/vim-less'
            Plug 'pangloss/vim-javascript'
            Plug 'briancollins/vim-jst'
            Plug 'kchmck/vim-coffee-script'
        endif
    " }

    " HTML {
        if BundleActive('html')
            Plug 'hail2u/vim-css3-syntax'
            Plug 'gorodinskiy/vim-coloresque'
            Plug 'tpope/vim-haml'
            Plug 'mattn/emmet-vim'
        endif
    " }

    " Latex {
        if BundleActive('latex')
            Plug 'lervag/vimtex'
        endif
    " }

    endif

    " Use local plugins.vim config if available {
        call SourceIfAvailable('plugins.vim')
    " }

    call plug#end()

" }}

" General {{

    set background=dark         " Assume a dark background

    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    if !exists('g:spf13_no_autochdir')
        augroup autochdir
            autocmd!
            " Always switch to the current file directory
            autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        augroup END
    endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

    augroup gitcommitsettings
        autocmd!
        " Instead of reverting the cursor to the last position in the buffer, we
        " set it to the first line when editing a git commit message
        au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    augroup END

    if !exists('g:spf13_no_restore_cursor')
        function! ResCur()
            if line("'\"") <= line('$')
                silent! normal! g`"
                return 1
            endif
        endfunction

        augroup resCur
            autocmd!
            autocmd BufWinEnter * call ResCur()
        augroup END
    endif

    " Setting up the directories {{
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif
    " }}

" }}

" Vim UI {{

    if has('termguicolors')
        set termguicolors
    endif

    " Set color schemes
    color gruvbox
    let g:airline_theme = 'gruvbox'

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    " This setting may have a notable performance impact if enabled
    set nocursorline                " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        if !exists('g:override_spf13_bundles')
            set statusline+=%{fugitive#statusline()} " Git Hotness
        endif
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:»·,trail:·,extends:#,nbsp:. " Highlight problematic whitespace

" }}

" Formatting {{

    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
" }}

" Key (re)Mappings {{

    if !exists('g:spf13_leader')
        let mapleader = ','
    else
        let mapleader=g:spf13_leader
    endif
    if !exists('g:spf13_localleader')
        let maplocalleader = '_'
    else
        let maplocalleader=g:spf13_localleader
    endif

    if !exists('g:spf13_no_easyWindows')
        map <C-J> <C-W>j<C-W>_
        map <C-K> <C-W>k<C-W>_
        map <C-L> <C-W>l<C-W>_
        map <C-H> <C-W>h<C-W>_
    endif

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    if !exists('g:spf13_no_wrapRelMotion')
        " Same for 0, home, end, etc
        function! WrapRelativeMotion(key, ...)
            let l:vis_sel=''
            if a:0
                let l:vis_sel='gv'
            endif
            if &wrap
                execute 'normal!' l:vis_sel . 'g' . a:key
            else
                execute 'normal!' l:vis_sel . a:key
            endif
        endfunction

        " Map g* keys in Normal, Operator-pending, and Visual+select
        noremap $ :call WrapRelativeMotion("$")<CR>
        noremap <End> :call WrapRelativeMotion("$")<CR>
        noremap 0 :call WrapRelativeMotion("0")<CR>
        noremap <Home> :call WrapRelativeMotion("0")<CR>
        noremap ^ :call WrapRelativeMotion("^")<CR>
        " Overwrite the operator pending $/<End> mappings from above
        " to force inclusive motion with :execute normal!
        onoremap $ v:call WrapRelativeMotion("$")<CR>
        onoremap <End> v:call WrapRelativeMotion("$")<CR>
        " Overwrite the Visual+select mode mappings from above
        " to ensure the correct vis_sel flag is passed to function
        vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
    endif

    if !exists('g:spf13_no_fastTabs')
        map <S-H> gT
        map <S-L> gt
    endif

    if !exists('g:spf13_no_keyfixes')
        if has('user_commands')
            command! -bang -nargs=* -complete=file E e<bang> <args>
            command! -bang -nargs=* -complete=file W w<bang> <args>
            command! -bang -nargs=* -complete=file Wq wq<bang> <args>
            command! -bang -nargs=* -complete=file WQ wq<bang> <args>
            command! -bang Wa wa<bang>
            command! -bang WA wa<bang>
            command! -bang Q q<bang>
            command! -bang QA qa<bang>
            command! -bang Qa qa<bang>
        endif

        cmap Tabe tabe
    endif

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    if exists('g:spf13_clear_search_highlight')
        nmap <silent> <leader>/ :nohlsearch<CR>
    else
        nmap <silent> <leader>/ :set invhlsearch<CR>
    endif


    " Find merge conflict markers
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Easier formatting
    nnoremap <silent> <leader>q gwip

" }}

" Plugin Configurations {{

    " Completion and LSP {{
        if BundleActive('completion')
lua <<EOF
            local cmp = require('cmp')
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
                    { name = 'nvim_lsp' },
                    { name = 'ultisnips' },
                }, {
                   { name = 'buffer' },
                })
            })

            -- Set configuration for specific file type
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'buffer' },
                })
            })

            -- Use buffer source for `/`
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':'
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })

            -- Setup LSP
            local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
            require('lspconfig')['clangd'].setup { capabilities = capabilities }
            require('lspconfig')['cmake'].setup { capabilities = capabilities }
            require('lspconfig')['pylsp'].setup { capabilities = capabilities }
            require('lspconfig')['texlab'].setup { capabilities = capabilities }
EOF
        endif
    " }}

    " ALE {{
        if PluginActive('ale')
            let g:airline#extensions#ale#enabled=1
            if BundleActive('c_cpp')
                let s:cpp_standard_flag='-std=c++20'
                let g:ale_c_cc_options='-Wall -Wextra -Wpedantic'
                let g:ale_c_cppcheck_options='--enable=style --suppress=syntaxError'
                let g:ale_cpp_cc_options=s:cpp_standard_flag . ' ' . g:ale_c_cc_options
                let g:ale_cpp_clangtidy_extra_options=g:ale_cpp_cc_options
                let g:ale_cpp_cppcheck_options=g:ale_c_cppcheck_options
                let g:ale_cpp_clangcheck_options='-extra-arg=' . s:cpp_standard_flag
                let g:ale_cpp_clangd_options=g:ale_cpp_cc_options
            endif
        endif
    " }}

    " TextObj Sentence {{
        if BundleActive('writing')
            augroup textobj_sentence
              autocmd!
              autocmd FileType markdown call textobj#sentence#init()
              autocmd FileType textile call textobj#sentence#init()
              autocmd FileType text call textobj#sentence#init()
            augroup END
        endif
    " }}

    " TextObj Quote {{
        if BundleActive('writing')
            augroup textobj_quote
                autocmd!
                autocmd FileType markdown call textobj#quote#init()
                autocmd FileType textile call textobj#quote#init()
                autocmd FileType text call textobj#quote#init({'educate': 0})
            augroup END
        endif
    " }}

    " Ctags {{
        set tags=./tags;/,~/.vimtags

        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot !=? ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }}

    " NerdTree {{
        if PluginActive('nerdtree')
            let g:NERDShutUp=1

            map <C-e> <plug>NERDTreeTabsToggle<CR>
            map <leader>e :NERDTreeFind<CR>
            nmap <leader>nt :NERDTreeFind<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=0
        endif
    " }}

    " Tabularize {{
        if PluginActive('tabular')
            nmap <Leader>a& :Tabularize /&<CR>
            vmap <Leader>a& :Tabularize /&<CR>
            nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            nmap <Leader>a=> :Tabularize /=><CR>
            vmap <Leader>a=> :Tabularize /=><CR>
            nmap <Leader>a: :Tabularize /:<CR>
            vmap <Leader>a: :Tabularize /:<CR>
            nmap <Leader>a:: :Tabularize /:\zs<CR>
            vmap <Leader>a:: :Tabularize /:\zs<CR>
            nmap <Leader>a, :Tabularize /,<CR>
            vmap <Leader>a, :Tabularize /,<CR>
            nmap <Leader>a,, :Tabularize /,\zs<CR>
            vmap <Leader>a,, :Tabularize /,\zs<CR>
            nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
            vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        endif
    " }}

    " Session List {{
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        if PluginActive('sessionman.vim')
            nmap <leader>sl :SessionList<CR>
            nmap <leader>ss :SessionSave<CR>
            nmap <leader>sc :SessionClose<CR>
        endif
    " }}

    " JSON {{
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        let g:vim_json_syntax_conceal = 0
    " }}

    " ctrlp {{
        if PluginActive('ctrlp.vim')
            let g:ctrlp_working_path_mode = 'ra'
            nnoremap <silent> <D-t> :CtrlP<CR>
            nnoremap <silent> <D-r> :CtrlPMRU<CR>
            let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

            if executable('ag')
                let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
            elseif executable('ack-grep')
                let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
            elseif executable('ack')
                let s:ctrlp_fallback = 'ack %s --nocolor -f'
            else
                let s:ctrlp_fallback = 'find %s -type f'
            endif
            if exists('g:ctrlp_user_command')
                unlet g:ctrlp_user_command
            endif
            let g:ctrlp_user_command = {
                \ 'types': {
                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': s:ctrlp_fallback
            \ }

            " CtrlP Funky extensions
            if PluginActive('ctrlp-funky')
                let g:ctrlp_extensions = ['funky']
                nnoremap <Leader>fu :CtrlPFunky<Cr>
            endif
        endif
    " }}

    " Rainbow {{
        if PluginActive('rainbow')
            let g:rainbow_active = 1
            " Disable for CMake as it breaks the syntax highlighting (#40)
            let g:rainbow_conf = {
            \   'separately': {
            \       'cmake': 0,
            \   }
            \}
        endif
    " }}

    " Fugitive {{
        if PluginActive('vim-fugitive')
            nnoremap <silent> <leader>gs :Git<CR>
            nnoremap <silent> <leader>gd :Gdiffsplit<CR>
            nnoremap <silent> <leader>gc :Git commit<CR>
            nnoremap <silent> <leader>gb :Git blame<CR>
            nnoremap <silent> <leader>gl :Gclog<CR>
            nnoremap <silent> <leader>gp :Git push<CR>
            nnoremap <silent> <leader>gr :Gread<CR>
            nnoremap <silent> <leader>gw :Gwrite<CR>
            nnoremap <silent> <leader>ge :Gedit<CR>
            " Mnemonic _i_nteractive
            nnoremap <silent> <leader>gi :Git add -p %<CR>
            nnoremap <silent> <leader>gg :SignifyToggle<CR>
            nnoremap <silent> <leader>gu :SignifyRefresh<CR>

            " Refresh Signify after commit
            au gitcommitsettings FileType gitcommit au! BufDelete COMMIT_EDITMSG SignifyRefresh
        endif
    " }}

    " vim-mundo {{
        if PluginActive('vim-mundo')
            nnoremap <F5> :MundoToggle<CR>
        endif
    " }}

    " Wildfire {{
        let g:wildfire_objects = {
            \ '*' : ['i''', 'i"', 'i)', 'i]', 'i}'],
            \ 'html,xml' : ['at', 'it'],
        \ }
    " }}

    " vim-airline {{
        if PluginActive('vim-airline-themes')
            let g:airline#extensions#tabline#enabled=1  " Smarter Tabline
            let g:airline_powerline_fonts=1             " Powerline Fonts
        endif
    " }}

    " vim-cpp-enhanced-highlight {{
        if PluginActive('vim-cpp-enhanced-highlight')
            let g:cpp_concepts_highlight = 1
        endif
    " }}

    " vim-closetag {{
        if PluginActive('vim-closetag')
            let g:closetag_filetypes = 'xml,html,xhtml,phtml'
        endif
    " }}

    " nvim-autopairs {{
        if PluginActive('nvim-autopairs')
            lua require('nvim-autopairs').setup{}
        endif
    " }}

" }}

" GUI Settings {{

    " GVIM- (here instead of .gvimrc)
    if GUI()
        set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24

        " FIXME: Revert this f70be548
        " fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
        map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>
    else
        if &term ==? 'xterm' || &term ==? 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif

" }}

" Functions {{

    " Initialize directories {{
    function! InitializeDirectories()
        let l:parent = $HOME . '/.config/nvim'
        let l:prefix = 'vim'
        let l:dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let l:dir_list['undo'] = 'undodir'
        endif

        let l:common_dir = l:parent . '/' . prefix

        for [dirname, settingname] in items(l:dir_list)
            let l:directory = common_dir . dirname . '/'
            if exists('*mkdir')
                if !isdirectory(l:directory)
                    call mkdir(l:directory, 'p')
                endif
            endif
            if !isdirectory(l:directory)
                echo 'Warning: Unable to create directory: ' . l:directory
                echo 'Try: mkdir -p ' . l:directory
            else
                let l:directory = substitute(l:directory, ' ', '\\\\ ', 'g')
                exec 'set ' . settingname . '=' . l:directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }}
" }}

" Use local.vim if available {{
    call SourceIfAvailable('local.vim')
" }}

" Use local gui.vim if available and gui is running {{
    if GUI()
        call SourceIfAvailable('gui.vim')
    endif
" }}
