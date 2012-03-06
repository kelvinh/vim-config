" Modeline and Note {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" This vimrc file is mainly copied from Steve Francia.
"                                      --- by Kelvin Hu
" }

" Environment {
"   Basic {
        set nocompatible
"   }

"   Setup Bundle Support {
        runtime! autoload/pathogen.vim
        silent! call pathogen#helptags()
        silent! call pathogen#runtime_append_all_bundles()
"   }
" }

" General {
    filetype plugin indent on   " automatically detect file types
    syntax on                   " syntax highlighting
    set mouse=a                 " enable mouse usage
    scriptencoding utf-8
    set viewoptions=folds,options,cursor,unix,slash " effect to be saved and restored
    set history=1000            " history count(default is 20)
    set spell                   " set spell checking on
    set autoread                " auto read file if it is changed outside
    set hidden                  " allow buffer switch without save

"   Folders and backup {
        set autochdir       " always switch to current file directory
        set nobackup        " do not backup files
        set nowritebackup   " do not do writable backup
        set noswapfile      " do not create swap file

        au BufWinLeave * silent! mkview     " make vim save view (state) (folds, cursor, etc)
        au BufWinEnter * silent! loadview   " make vim load view (state) (folds, cursor, etc)
"   }

"   Encoding {
        set encoding=utf-8
        set ffs=dos,unix,mac " file types(mainly EOL, \n\r or \n)
"   }
" }

" UI {
    au GUIEnter * simalt ~x         " to maximize vim when starting

    if has("gui_running")
        set background=dark
        syntax reset                " enable syntax after background color is set
        colorscheme solarized       " baycomb2 darkbone vividchalk neon freya baycomb ron molokai
        set guifont=Courier_New:h11
        set guioptions=ce

        set mousehide               " hide the mouse cursor when typing
    else
        set background=dark
        syntax reset
        colorscheme xoria256 " wombat256
    endif

    if has('cmdline_info')
        set ruler       " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd     " show partial commands in status line and
    endif

    set showmode
    set number          " show line numbers
    set wrap
    set cmdheight=1     " set command line height
    set scrolloff=7     " 当光标距下边距7行时开始滚屏

    set cursorline      " highlight current line
    set cursorcolumn    " highlight current column

    if has('statusline')
        set laststatus=2    " always show status line

        "set statusline=%<%f\ " Filename
        "set statusline+=%w%h%m%r " Options
        "set statusline+=%{fugitive#statusline()} " Git Hotness
        "set statusline+=\ [%{&ff}/%Y] " filetype
        "set statusline+=\ [%{getcwd()}] " current dir
        "set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info

        set statusline=%F\ %m\ %r\ %h\ %w\ [%{&ff}]\ %y\ [0x%B]\ %=%l,\ %c%V\ \ \ \ \ \ \ <%p%%>\ \  
    endif

    set linespace=0     " do not show any pixels between lines

"   Search effect {
        set showmatch   " match ()/{}/[] etc
        set incsearch   " go to the matched string while searching
        set hlsearch    " highlight the search string
        set ignorecase  " ignore case when searching
        set smartcase   " smart case when searching
"   }
" }

" Edit {
"   tab and indent {
        set expandtab       " insert spaces instead when inserting tab
        set shiftwidth=4    " space number when auto indent
        set tabstop=4       " set tab=4 spaces
        set softtabstop=4
        set smarttab        " when backspace, it will delete 4 spaces at front of a line
        set autoindent
        set smartindent

        set list
        "set listchars=tab:>-,trail:-
        set listchars=tab:^.,trail:-,extends:#,nbsp:*
"   }

"   fold {
        set foldenable          " enable code fold
        au FileType javascript set foldmarker={,}
        "au FileType javascript set foldlevel=1
        au FileType javascript set foldmethod=marker
        "set foldmethod=syntax   " foldmethod=manual, indent, syntax, marker
        "set foldcolumn=2        " 2 column left to display fold info
"   }

    set linebreak " 智能换行
    set backspace=indent,eol,start
    set whichwrap+=<,>,[,]
" }

" Key mapping {
    let mapleader = ','

    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-H> <C-W>h
    map <C-L> <C-W>l

    if has('win32') || has('win64')
        nmap <Leader>ec :e $VIM/_vimrc<CR>
    else
        nmap <Leader>ec :e ~/.vimrc<CR>
    endif

    nnoremap j gj
    nnoremap k gk

    vnoremap < <gv
    vnoremap > >gv

    vnoremap ,y "+y
    map ,p "+p
    map ,yy "+yy
    map ,yw "+yiw
    map ,y' "+yi'
    map ,y" "+yi"
" }

" Plugins {
    " full screen {
        if has('win32') " only useful under windows
            map <F11> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
        endif
    " }

    " NeoComplCahce {
        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_enable_camel_case_completion = 1
        let g:neocomplcache_enable_smart_case = 1
        let g:neocomplcache_enable_underbar_completion = 1
        let g:neocomplcache_min_syntax_length = 3
        "let g:neocomplcache_enable_auto_delimiter = 1
        "let g:neocomplcache_enable_auto_select = 0

        " SuperTab like snippets behavior.
        "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

        imap <C-k>  <Plug>(neocomplcache_snippets_expand)
        smap <C-k>  <Plug>(neocomplcache_snippets_expand)
        inoremap <expr><C-g>  neocomplcache#undo_completion()
        inoremap <expr><C-l>  neocomplcache#complete_common_string()

        inoremap <expr><CR>  neocomplcache#smart_close_popup()."\<CR>"
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        inoremap <expr><C-h>  neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplcache#close_popup()
        inoremap <expr><C-e>  neocomplcache#cancel_popup()

        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        "autocmd FileType java setlocal omnifunc=javacomplete#Complete

        " Enable heavy omni completion.
        if !exists('g:neocomplcache_omni_patterns')
            let g:neocomplcache_omni_patterns = {}
        endif
    " }

    " AutoCloseTag {
"        au FileType xhtml,xml ru autoclosetag/autoclosetag.vim
"        nmap <Leader>ac <Plug>ToggleAutoCloseMappings
    "}

    " Perforce {
        let g:p4CmdPath = 'C:/SDTs/Perforce/p4.exe'
        let g:p4DefaultPreset = 'cn-p4proxy:1667 default.kelvin_hu.WFRM-Dev kelvin_hu'
        let g:p4ClientRoot = 'D:/Workspace/WFRM/Account_Dev'
        let g:p4Depot = 'SMB'
    " }

    " Mini Buffer Explorer {
        " MiniBufExpl Colors
        hi MBEVisibleActive guifg=#A6DB29 guibg=fg
        hi MBEVisibleChangedActive guifg=#F1266F guibg=fg
        hi MBEVisibleChanged guifg=#F1266F guibg=fg
        hi MBEVisibleNormal guifg=#5DC2D6 guibg=fg
        hi MBEChanged guifg=#CD5907 guibg=fg
        hi MBENormal guifg=#808080 guibg=fg

        let g:miniBufExplorerMoreThanOne=1
        let g:miniBufExplMapCTabSwitchBufs = 1
        let g:miniBufExplCheckDupeBufs = 0

        au BufRead,BufNew :call UMiniBufExplorer

        nmap <Leader>mt :TMiniBufExplorer<CR>
    " }

    " csExplorer {
        nmap <Leader>co :ColorSchemeExplorer<CR>
    " }

    " Fuzzy Finder {
        nmap <Leader>fb :FufBuffer<CR>
        nmap <Leader>ff :FufFile **/<CR>
        nmap <Leader>fl :FufLine<CR>
    " }

    " NERDTree {
        "let NERDTreeDirArrows=1 " it will lead to messy code
        map <F10> :NERDTreeToggle<CR>
    " }

    " Tagbar {
        let g:tagbar_ctags_bin = 'C:\SDTs\Vim\vim73\ctags.exe'
        let g:tagbar_left = 0
        let g:tagbar_width = 30
        nnoremap <silent> <F9> :TagbarToggle<CR>
    " }

    " javascript fold {
"        au FileType javascript call JavaScriptFold()
"        au FileType javascript setl fen
"        au FileType javascript setl nocindent
"
"        function! JavaScriptFold()
"            setl foldmethod=syntax
"            setl foldlevelstart=1
"            syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
"
"            function! FoldText()
"                return substitute(getline(v:foldstart), '{.*', '{...}', '')
"            endfunction
"            setl foldtext=FoldText()
"        endfunction
    " }
" }
