" Vundle part
"""""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugin list
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'xolox/vim-lua-inspect'
Plugin 'xolox/vim-misc'
Plugin 'vim-ruby/vim-ruby'
Plugin 'jansenm/vim-cmake'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'mfukar/robotframework-vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'mbbill/undotree'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
" End plugin list

call vundle#end()            " required
filetype plugin indent on    " required

" Airline config
""""""""""""""""""""

let g:airline_theme = 'dark'
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" Basic config
""""""""""""""

" Set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" Use indentation of previous line
set autoindent

" Tab and spaces configuration
set tabstop=4     " tab = 4 spaces
set shiftwidth=4  " indent = 4 spaces
set expandtab     " expand tabs to spaces

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Activate syntax
syntax on

" Show line number
set number

" Highlight search matches
set hlsearch

" Highlign color
hi Search cterm=NONE ctermfg=black ctermbg=green

" Show full path in status bar
set statusline+=%F

" Show tab as char
set list
set listchars=tab:~\ 

" Next buffer and previous
nnoremap gn :bn<CR>
nnoremap gN :bp<CR>

" Show trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
2match ExtraWhitespace /\s\+$/

" Highlight characters exceeding 161
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
2match OverLength /\%161v.\+/

" Eliminating delays on ESC with VIM and ZSH
set timeoutlen=1000 ttimeoutlen=50

" Highlight the current line
set cursorline

" Set cursorline colors
highlight CursorLine ctermbg=235 guibg=Gray40 cterm=none

" Set color of number column on cursorline
highlight CursorLineNR ctermbg=235 ctermfg=white

" Disable spell
set nospell

" Persistent undo handling
set undofile
" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir
" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" Disable arrows to master vim
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" Relative number
function! NumberToggle()
  set relativenumber!
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

" Default to relative mode
set relativenumber

" Highlight matching braces
set showmatch

" Source bepo configuration
"source ~/.vimrc.bepo