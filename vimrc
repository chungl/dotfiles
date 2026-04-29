set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on

let mapleader = " "

call plug#begin()
" TODO - Add vim plug to vim installer:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
Plug 'wellle/context.vim'
Plug 'ton/vim-bufsurf'
Plug 'moll/vim-bbye'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'sainnhe/sonokai'
Plug 'airblade/vim-gitgutter'
Plug 'joshdick/onedark.vim'
call plug#end()

colorscheme sonokai

set updatetime=100

set autoread
set autowrite
set autowriteall

set hidden
set number
set cursorline

set shiftwidth=4
set tabstop=4
set expandtab

set ignorecase
set smartcase

set showcmd
set showmode
set showmatch
set hlsearch

if has('macunix')
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

" Esc to normal from terminal
tnoremap <Esc> <C-\><C-n>
" Esc clears highlights
nnoremap <Esc> :noh<CR><Esc>

" Buffer navigation per window
nnoremap <S-h> :BufSurfBack<CR>
nnoremap <S-l> :BufSurfForward<CR>

" Close buffer without wrecking the window, falling back to history first
nnoremap <leader>bd :BufSurfBack<CR>:Bdelete #<CR>

command! -nargs=1 HelmValues execute 'enew | file helm/<args> | read !helm show values <args>' | execute '1d' | execute 'setlocal nomodifiable'
" TODO: depends on .zshenv, does not load .zshrc. 
" WARN: Currently needs manual install/sync
command! -nargs=* Bcalb execute 'normal! a' . system('bcalb ' . <q-args>)
