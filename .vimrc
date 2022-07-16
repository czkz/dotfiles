" Quickstart:
" 1. curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 2. In vim :PlugInstall
" 3. mkdir ~/.vimundo
" 4. Take a look at Mappings, IDE features, and Personal settings
"
" Using Shift+K on plugin name (or anything else in this file) will likely show what it does
"
" F9 usage:
" Executes current file if it is executable.
" Otherwise detects meson and npm projects.
" Can be overridden with :let f9='whoami'
" For simple projects chmod +x and add a shebang like
" - #!/usr/bin/env python
" - /*bin/true && exec tcc -run "$0" "$@";*/
" - //bin/true && exec ./run.sh
" - #!/usr/bin/env -S vala -g --pkg=gio-2.0 --pkg=gtk+-3.0 -X -rdynamic
"
" Completion:
" Dumb completion is always available on Ctrl+N.
" Smart completion needs appropriate tools installed,
" like clangd for C/C++, tsserver for JavaScript, etc.
" For a full list of supported tools see
" https://github.com/dense-analysis/ale/blob/master/supported-tools.md
" For a list of supported/active tools for current file see :ALEInfo
"
" C/C++ LSP:
" Uses compile_commands.json or default settings
" Generated automatically in meson projects
" For cmake see CMAKE_EXPORT_COMPILE_COMMANDS


" Plugins ──────────────────────────────────────────────────────────────────────

call plug#begin()
" General-purpose
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'raimondi/delimitmate'
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/vim-easy-align'
Plug 'jasonccox/vim-wayland-clipboard'
" LSP client
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'rhysd/vim-lsp-ale'
" HTML
Plug 'AndrewRadev/tagalong.vim'
Plug 'mattn/emmet-vim'
" Language support
Plug 'igankevich/mesonic'
Plug 'tikhomirov/vim-glsl'
Plug 'arrufat/vala.vim'
Plug 'ollykel/v-vim'
call plug#end()


" Mappings ─────────────────────────────────────────────────────────────────────

" Ctrl+L disables search highlighting
nnoremap <c-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Ctrl+C yanks to system buffer
nmap <c-c> "+y
vmap <c-c> "+y
nmap <c-c><c-c> ^"+y$

" Copy buffer to clipboard on <F10>
map <F10> <Esc>gg"+yG``

" Ctrl+S saves file
nnoremap <c-s>      :w<cr>
inoremap <c-s> <esc>:w<cr>

" Ctrl+P opens fzf-vim file selector
" g+Ctrl+P opens multifile search (ripgrep)
" Ctrl+H is a better git status
" g+Ctrl+H is a better git log
" Ctrl+Shift+/ opens multifile search for word under cursor
nnoremap  <c-p> :up<cr>:Files<cr>
nnoremap g<c-p> :up<cr>:RG<cr>
nnoremap  <c-h> :up<cr>:GFiles?<cr>
nnoremap g<c-h> :up<cr>:BCommits<cr>
nnoremap  <c-?> :up<cr>:exe 'Rg \b'.expand('<cword>').'\b'<cr>

" Toggle line wrapping
nnoremap <silent> <leader>w :set wrap!<CR>:set wrap?<CR>

" g+Ctrl+U opens undo tree
nnoremap g<c-u> :UndotreeToggle<cr>:UndotreeFocus<cr>

" Move current line up/down
nnoremap [e  :execute 'move -1-'. v:count1<cr>==
nnoremap ]e  :execute 'move +'. v:count1<cr>==

" Tab and Shift+Tab navigate completion menu
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Toggle comment on Ctrl+/
" Ctrl+/ is actually Ctrl+_ on some terminals for some reason
nnoremap <silent> <c-_> :call nerdcommenter#Comment("n", "Toggle")<CR>
vnoremap <silent> <c-_> :call nerdcommenter#Comment("v", "Toggle")<CR>

" @s renames all occurences of word under cursor
let @s=":ZeroStar\<cr>:%s///g\<left>\<left>"
" @b unfolds one line code block into 3 lines
" cursor must be on the first bracket
let @b="cs{}v%hols\<cr>\<c-r>\"\<esc>gv\<esc>"

" Execute current file on <F9>
" or build and run a meson project
nnoremap <F9>      :up<CR>:call SmartF9()<CR>
inoremap <F9> <Esc>:up<CR>:call SmartF9()<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)*
xmap gA <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Map emmet to Ctrl+Q (in insert mode)
imap <C-Q> <c-r>=emmet#util#closePopup()<cr><c-r>=emmet#expandAbbr(0,"")<cr>

" Safer ZQ
nnoremap ZQ :q<CR>

" 0 moves to first nonblank character in current line
" faster to press than Shift+6
nnoremap 0 ^

" # highlights word under cursor
nnoremap <silent> # :ZeroStar<CR>

" Y yanks until end of line
nnoremap Y y$

" Line shift keeps selection
vnoremap < <gv
vnoremap > >gv

" jk moves 1 line on wrapped lines
nnoremap j gj
nnoremap k gk

" Switch tabs with \1, \2, \3, etc.
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab0
nmap gt <Plug>AirlineSelectNextTab
nmap gT <Plug>AirlineSelectPrevTab

" IDE Features ─────────────────────────────────────────────────────────────────

" Complete *when typing* (misleading name!)
let g:ale_completion_enabled = 1

" Ctrl+Space forces completion
" Ctrl+Space is actually Ctrl+@ on some terminals for some reason
inoremap <C-@> <Plug>(ale_complete)

" Smart rename on <F2>
nnoremap <F2> :ALERename<CR>

" Ctrl+] - Go to defenition
nnoremap <expr>  <C-]> &ft == 'help' ?  '<C-]>' : ':up<CR>:ALEGoToDefinition<CR>'
nnoremap g<C-]> <C-]>

" \i     - Show function/type info
nmap <leader>i <Plug>(ale_hover)

" \]     - List references (q to quit, Enter to goto)
nnoremap <Leader>] :ALEFindReferences<CR>

" \f     - Open FixIt
nnoremap <leader>f :ALECodeAction<CR>

" \e     - Open verbose error description
nnoremap <leader>e :ALEDetail<CR>


" Personal settings ────────────────────────────────────────────────────────────

set tabstop=4                  " Set tab width
set expandtab                  " Convert tabs to spaces
" set relativenumber             " Line number offsets for hjkl
" set nowrap                     " Do not wrap lines
let &showbreak = '>   '        " Insert on wrapped lines
set scrolloff=5                " Always keep 5 lines above/below cursor
let g:tw=0                     " Highlight lines longer than this (if not zero)
" set colorcolumn=81             " Highlight Nth column
let g:tabline_buffers = 1      " Buffers act like tabs when there's one tab


" Plugin settings ──────────────────────────────────────────────────────────────

" vim-airline
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ' '
let g:airline_symbols.colnr = ':'
let g:airline_symbols.maxlinenr = ''
if g:tabline_buffers == 1    " With buffers
    " Intrusive tabline
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_splits = 0
    let g:airline#extensions#tabline#tab_nr_type = 1
    let g:airline#extensions#tabline#buffer_idx_mode = 1
    let g:airline#extensions#tabline#tab_min_count = 2
    let g:airline#extensions#tabline#buffer_min_count = 2
else
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_splits = 0
    let g:airline#extensions#tabline#show_buffers = 0
    let g:airline#extensions#tabline#show_tab_count = 0
    let g:airline#extensions#tabline#show_tab_nr = 0
    let g:airline#extensions#tabline#show_tab_type = 0
    let g:airline#extensions#tabline#tab_min_count = 2
endif

" fzf-vim
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 1.0 } }
let g:fzf_preview_window = ['right:60%', 'ctrl-/']    " Hide preview window on Ctrl+/
" See :h fzf-vim-example-advanced-ripgrep-integration
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" delimitMate
let delimitMate_expand_cr = 1           " Expand {<CR> into 3 lines
let delimitMate_expand_space = 1        " Expand '{ ' into '{ _ }'
let delimitMate_jump_expansion = 1      " Jump to closing bracket over whitespace

" NerdCommenter
let g:NERDSpaceDelims = 1               " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1           " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left'         " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCommentEmptyLines = 1         " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1    " Enable trimming of trailing whitespace when uncommenting

" ale
let g:ale_echo_msg_format = '%s'                 " Shorter messages
let g:ale_hover_cursor = 0                       " Disable cursor hover msg
let g:ale_hover_to_floating_preview = 1          " Enable floating windows
let g:ale_set_balloons = 1                       " Mouse over symbol shows info
let g:ale_cpp_cc_options = '-std=c++20 -Wall'    " Fallback C++ options

" vim-lsp
if executable('vala-language-server')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'vala-language-server',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'vala-language-server']},
      \ 'whitelist': ['vala', 'genie'],
      \ })
endif

" emmet
let g:user_emmet_install_global = 0    " Disable default emmet mappings

" v-vim
let g:v_highlight_trailing_whitespace_error = 0


" Sensible defaults ────────────────────────────────────────────────────────────

set linebreak                  " Don't wrap in the middle of a word
colorscheme default            " Color scheme
set background=dark            " Not valid for all color schemes
set shiftwidth=0               " Infer from tabstop
set smarttab                   " Delete spaces like tabs
set hlsearch                   " Highlight searches
set incsearch                  " Highlight when typing
syntax on                      " Syntax highlighting
set autowrite                  " Autosave on :make, :next, C-^, etc
" set autowriteall               " Autosave on :e, :q, :qa
set splitright                 " Split to the right instead of to the left
set foldmethod=indent          " Fold by indentation
set foldlevelstart=99          " Do not close folds automatically
set mouse=a                    " Enable mouse in all modes
set ignorecase                 " Use case insensitive search
set smartcase                  " Except when using capital letters
set number                     " Show current line number
set clipboard=unnamed          " Use system clipboard for yank/paste
set undofile                   " Persistent undo history
set undodir=~/.vimundo/        " Path to store undo history
set wildmenu                   " Autocompletion menu for :commands
set wildmode=list:longest,full " Autocompletion menu style
set completeopt=menuone,popup  " Prettier code autocompletion
set shortmess-=S               " Show search match index in statusline

" Fixes freezing when typing <Esc>O in insert mode
set timeout timeoutlen=3000 ttimeoutlen=100

" Mouse support in Alacritty
if $TERM == 'alacritty' | set ttymouse=sgr | endif

" HTML tag support for % (":h matchit" if enabled)
packadd! matchit

" Awesome GDB integration
packadd! termdebug

" Load bash aliases, check in .bashrc for $VIM
let $BASH_ENV = "~/.bashrc"


augroup vimrc
    autocmd!

    " Disable automatic comment insertion on o and i_<CR>
    autocmd FileType * setlocal fo-=ro

    " Highlight characters in column after g:tw
    autocmd BufWinEnter * if g:tw | call matchadd('ErrorMsg', '\%'.(g:tw + 1).'v', -1) | endif

    " Highlight trailing whitespace
    highlight TrailingWhitespace ctermbg=red guibg=red
    autocmd BufWinEnter * match TrailingWhitespace /\s\+$/
    autocmd InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match TrailingWhitespace /\s\+$/

    " Matches cleanup
    autocmd BufWinLeave * call clearmatches()

    " Remeber cursor position in buffers, see :h restore-cursor
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

    " Source vimrc after saving
    autocmd BufWritePost ~/.vimrc source ~/.vimrc

    " Save html after every edit for frequent Alt-Tabs
    " autocmd TextChanged,InsertLeave *.html write

    " Proper vfmt integration
    autocmd FileType vlang nnoremap <buffer> = :call _VFormatFile_patched()<CR>

augroup end


" :ZeroStar highlights word under cursor, like *N
command ZeroStar let @/ = '\<'.expand('<cword>').'\>' | set hls

function SmartF9() abort
    if exists('g:f9')
        execute '!clear && ' . g:f9
    elseif executable(expand('%:p'))
        execute '!clear && ' . shellescape(expand('%:p'))
    elseif filereadable(MesonProjectDir() . 'meson.build') && stridx(expand('%:p'), MesonProjectDir()) == 0
        return MesonBuildAndRun()
    elseif filereadable(getcwd() . '/package.json') && stridx(expand('%:p'), getcwd() . '/') == 0
        execute '!clear && npm start'
    else " Offer to chmod +x
        let l:cmd = 'chmod +x ' . shellescape(expand('%'))
        execute '!clear && echo -n ' . l:cmd . '"? [Y/n] " && (read -n1 ans; [ "$?" = 0 -a "$ans" = "" ] && ans=y || echo; [ "$ans" = "y" ] && ' . l:cmd . ')'
    endif
endfunction

function MesonBuildAndRun() abort
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

function _VFormatFile_patched() abort
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
