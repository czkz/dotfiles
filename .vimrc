" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin()
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'raimondi/delimitmate'
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/vim-easy-align'
Plug 'jasonccox/vim-wayland-clipboard'
" Language support
" Plug 'AndrewRadev/tagalong.vim'
" Plug 'mattn/emmet-vim'
" Plug 'ycm-core/YouCompleteMe'
" Plug 'igankevich/mesonic'
" Plug 'tikhomirov/vim-glsl'
" Plug 'arrufat/vala.vim'
" Plug 'ollykel/v-vim'
" Plug 'ziglang/zig.vim'
call plug#end()



" Ctrl+L disables search highlighting
nnoremap <c-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr>:silent! YcmForceCompileAndDiagnostics<cr><c-l>

" Ctrl+C yanks to system buffer
nmap <c-c> "+y
vmap <c-c> "+y
nmap <c-c><c-c> ^"+y$

" Ctrl+S saves file
nnoremap <c-s> :w<cr>

" Ctrl+P opens fzf-vim file selector
" g+Ctrl+P opens multifile search
nnoremap <c-p> :up<cr>:Files<cr>
nnoremap g<c-p> :up<cr>:Rg<cr>
nnoremap <c-h> :up<cr>:GFiles?<cr>
nnoremap g<c-h> :up<cr>:BCommits<cr>

" gs executes git status
" gj loads left hunk (when merging)
" gk loads right hunk (when merging)
nnoremap gs :G<CR>
nnoremap gj :diffget //2<CR>
nnoremap gk :diffget //3<CR>

" g+Ctrl+U opens undo tree
nnoremap g<c-u> :UndotreeToggle<cr>:UndotreeFocus<cr>

" Move current line up/down
nnoremap [e  :execute 'move -1-'. v:count1<cr>==
nnoremap ]e  :execute 'move +'. v:count1<cr>==

" Safe quit on ZQ
nnoremap ZQ :q<CR>

" Y yanks until end of line
nnoremap Y y$

" Line shift keeps selection
vnoremap < <gv
vnoremap > >gv

" 0 moves to first nonblank character in current line
nnoremap 0 ^

" jk moves 1 line on wrapped lines
nnoremap j gj
nnoremap k gk

" Toggle comment on Ctrl+/
" Ctrl+/ is actually Ctrl+_ on some terminals for some reason
nnoremap <silent> <c-_> :call nerdcommenter#Comment("n", "Toggle")<CR>
vnoremap <silent> <c-_> :call nerdcommenter#Comment("v", "Toggle")<CR>

" Smart rename on '<F2> new_name'
nnoremap <F2> :YcmCompleter RefactorRename

" Exec current file on <F9>
nnoremap <F9>      :up<CR>:exe '!clear && ' . shellescape(expand("%:p"))<CR>
inoremap <F9> <Esc>:up<CR>:exe '!clear && ' . shellescape(expand("%:p"))<CR>

" Copy buffer to clipboard on <F10>
map <F10> <Esc>gg"+yG``

" Ctrl+] - Go to defenition/declaration
nnoremap <C-]> :up<CR>:YcmCompleter GoTo<CR>
nnoremap g<C-]> <C-]>
" \]     - List references, use with :cope, :cn, :cp
nnoremap <Leader>] :YcmCompleter GoToReferences<CR>
" \f     - Open FixIt
nnoremap <leader>f :YcmCompleter FixIt<CR>


" @s renames all occurences of word under cursor
let @s="*N:%s///g\<left>\<left>"
" @b unfolds one line code block into 3 lines
" cursor must be on the first bracket
let @b="v%hols\<cr>\<c-r>\"\<esc>gv\<esc>"



" Set tab width; expandtab converts tabs to spaces
set tabstop=4 softtabstop=0 shiftwidth=0
set smarttab                   " Delete spaces like tabs
set expandtab                  " Convert tabs to spaces
set hlsearch                   " Highlight searches
set incsearch                  " Highlight when typing
syntax on                      " Syntax highlighting
colorscheme default            " Color scheme
set background=dark            " Not valid for all color schemes
set autowrite                  " Autosave on :make, :next, C-^, etc
" set autowriteall               " Autosave on :e, :q, :qa
set splitright                 " Split to the right instead of to the left
set foldmethod=indent          " Fold by indentation
set foldlevelstart=99          " Do not close folds automatically
set mouse=a                    " Enable mouse in all modes
set ignorecase                 " Use case insensitive search
set smartcase                  " Except when using capital letters
" set relativenumber             " Line number offsets for hjkl
set number                     " Show current line number
set clipboard=unnamed          " Use system clipboard for yank/paste
set undofile                   " Persistent undo history
set undodir=~/.vimundo/        " Path to store undo history
set wildmenu                   " Autocompletion menu for :commands
set wildmode=list:longest,full " Autocompletion menu style
set completeopt=menuone,popup  " Prettier code autocompletion
set shortmess-=S               " Show search match index in statusline
set scrolloff=5                " Always keep 5 lines above/below cursor
set nowrap                     " Do not wrap lines

" Fixes freezing when typing <Esc>O in insert mode
set timeout timeoutlen=3000 ttimeoutlen=100

" Mouse support in Alacritty
if $TERM == 'alacritty' | set ttymouse=sgr | endif

" HTML tag support for % (":h matchit" if enabled)
packadd! matchit

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)*
xmap gA <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Load bash aliases, check in .bashrc for $BASH_FROM_VIM
let $BASH_ENV = "~/.bashrc"
let $BASH_FROM_VIM = "1"



augroup default_au
    autocmd!

    " Disable automatic comment insertion on o and i_<CR>
    autocmd FileType * setlocal fo-=ro

    " Remeber cursor position in buffers, see :h restore-cursor
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

    " Make *.h files C++, not C
    autocmd BufRead,BufNewFile *.h setlocal filetype=cpp

    " Source vimrc after saving
    autocmd BufWritePost ~/.vimrc source ~/.vimrc

    " Save html after every edit for frequent Alt-Tabs
    " autocmd TextChanged,InsertLeave *.html write

    autocmd FileType cpp nnoremap <buffer> <F5> :exe '!clear && g++ -o temp ' . shellescape(expand("%"))) . ' -std=c++17 && (./temp; rm temp)'<CR>
    autocmd FileType c nnoremap <buffer> <F5> :exe '!clear && gcc -o temp ' . shellescape(expand("%"))) . ' -std=c11 && (./temp; rm temp)'<CR>

    " MesonBuildAndRun() on <F9> in meson projects if there's a meson.build file
    autocmd FileType cpp call RemapF9()
    autocmd FileType vala call RemapF9()
    function RemapF9()
        if filereadable('meson.build')
            nnoremap <F9>      :call MesonBuildAndRun()<CR>
            inoremap <F9> <Esc>:call MesonBuildAndRun()<CR>
        endif
    endfunction

    autocmd FileType vlang nnoremap <buffer> <F9> :exe '!clear && v run ' . shellescape(expand("%"))<CR>
    autocmd FileType vlang inoremap <buffer> <F9> <Esc>:exe '!clear && v run ' . shellescape(expand("%"))<CR>
    autocmd FileType vlang nnoremap <buffer> = :call _VFormatFile_patched()<CR>


augroup END



" Colored output for Ninja, breaks :make
" let b:meson_ninja_command = 'CLICOLOR_FORCE=1 ninja'

" vim-airline
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ' '
let g:airline_symbols.colnr = ':'
let g:airline_symbols.maxlinenr = ''

" fzf-vim
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 1.0 } }
let g:fzf_preview_window = ['right:60%', 'ctrl-/']

" delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1

" NerdCommenter
let g:NERDSpaceDelims = 1               " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1           " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left'         " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCommentEmptyLines = 1         " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1    " Enable trimming of trailing whitespace when uncommenting

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim_ycm_extra_conf.py'
let g:ycm_extra_conf_vim_data = ['MesonBuildDir(MesonProjectDir())']
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_error_symbol = '#'
let g:ycm_warning_symbol = '#'
let g:ycm_auto_hover = ''
let g:ycm_key_detailed_diagnostics = '<leader>e'  " On line with an error, show full error
" Show documentation for item under cursor on \i
nmap <leader>i <plug>(YCMHover)
" Trigger completion after typing three letters for these languages
let g:ycm_semantic_triggers = {
\    'perl6,python,cpp': ['re!\w{3}'],
\}
" Lsp config
let g:ycm_language_server =
  \ [
  \   {
  \     'name': 'vala',
  \     'cmdline': [ 'vala-language-server' ],
  \     'filetypes': [ 'vala', 'genie' ]
  \   },
  \   {
  \     'name': 'zls',
  \     'cmdline': [ 'zls' ],
  \     'filetypes': [ 'zig' ]
  \   }
  \ ]

" Disable all default emmet mappings, map expand on Ctrl+V
let g:user_emmet_install_global = 0
imap <C-Q> <c-r>=emmet#util#closePopup()<cr><c-r>=emmet#expandAbbr(0,"")<cr>

" Disable all default Auto Pairs mappings
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''

" v-vim options
let g:v_highlight_trailing_whitespace_error = 0
" let g:v_autofmt_bufwritepre = 1


function! MesonBuildAndRun()
    " silent execute "!clear"
    " make!
    execute "!clear && CLICOLOR_FORCE=1" &makeprg
    " if len(filter(getqflist(), 'v:val.valid')) == 0
    if v:shell_error == 0
        let l:p_dir = MesonProjectDir()
        let l:b_dir = MesonBuildDir(l:p_dir)
        let l:f_short = system("basename " . l:p_dir)

        let l:exe_list = systemlist("find " . l:b_dir . " -maxdepth 1 -type f -readable -executable")
        if empty(l:exe_list)
            echoerr "No executables in build dir"
        endif

        " Use exe name same as project name, if exists
        let l:i = index(exe_list, l:b_dir . system("basename " . l:p_dir))
        execute "!" . exe_list[l:i != -1 ? l:i : 0]
        " normal ``
    endif
endfunction

function! _VFormatFile_patched()
    let substitution = system("v fmt -", join(getline(1, line('$')), "\n"))
    if v:shell_error != 0
        echoerr "While formatting the buffer via vfmt, the following error occurred:"
        echoerr printf("ERROR(%d): %s", v:shell_error, substitution)
    else
        let [_, lnum, colnum, _] = getpos('.')
        %delete
        call setline(1, split(substitution, "\n"))
        call cursor(lnum, colnum)
    endif
endfunction
