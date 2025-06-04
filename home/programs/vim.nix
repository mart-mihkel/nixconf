{pkgs, ...}: {
  home.packages = with pkgs; [vim];
  home.file.".vimrc".text = ''
    set nocompatible

    set number
    set relativenumber

    set hidden
    set path+=**
    set wildmenu
    set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*/node_modules/*,*/.venv/*
    set complete=.,w,b,u,t

    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set shiftround
    set expandtab
    set smarttab

    set autoindent
    set copyindent
    set breakindent

    set ignorecase
    set smartcase

    set history=1000
    set undolevels=1000
    set undofile
    set swapfile backup undofile
    set undodir=~/.vim
    set backupdir=~/.vim
    set directory=~/.vim

    set incsearch
    set hlsearch

    set ruler
    set showmatch
    set cursorline
    set lazyredraw
    set scrolloff=4

    set list
    set listchars=tab:··,trail:·

    set splitright
    set splitbelow
    set laststatus=2

    set termguicolors
    set encoding=utf-8
    set background=dark

    let mapleader=" "
    let g:netrw_banner=0

    colorscheme sorbet

    syntax on
    filetype plugin on

    nnoremap <space> <nop>

    nnoremap j gj
    vnoremap j gj
    nnoremap k gk
    vnoremap k gk

    nnoremap <C-j> :cnext<CR>
    vnoremap <C-j> :cnext<CR>
    nnoremap <C-k> :cprevious<CR>
    vnoremap <C-k> :cprevious<CR>

    nnoremap <C-l> :lnext<CR>
    vnoremap <C-l> :lnext<CR>
    nnoremap <C-h> :lprevious<CR>
    vnoremap <C-h> :lprevious<CR>

    nnoremap <leader>f :%s/\s\+$//e<CR>
  '';
}
