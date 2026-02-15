" =============================================================================
" Sensible Vim defaults — works for most users
" =============================================================================

" -----------------------------------------------------------------------------
" Appearance
" -----------------------------------------------------------------------------
set number                    " Show line numbers
set relativenumber            " Relative line numbers (helps with motions like 5j)
set cursorline                " Highlight current line
set showmatch                 " Briefly jump to matching bracket
set signcolumn=yes            " Always show sign column (avoids layout shift)
set wrap                      " Wrap long lines
set linebreak                 " Wrap at word boundaries, not mid-word
set scrolloff=3               " Keep 3 lines visible above/below cursor
set sidescrolloff=5           " Keep 5 columns visible left/right
set laststatus=2              " Always show status line
set showcmd                   " Show command being typed in status line
set shortmess+=c              " Don't show completion messages (e.g. -- XXX completion)

" -----------------------------------------------------------------------------
" Indentation & tabs
" -----------------------------------------------------------------------------
set tabstop=2                 " Width of a tab character
set shiftwidth=2              " Indent size for <<, >>, autoindent
set expandtab                 " Use spaces instead of tab characters
set autoindent                " Copy indent from current line to new line
set smartindent               " Smarter indentation (e.g. after {)

" -----------------------------------------------------------------------------
" Search & replace
" -----------------------------------------------------------------------------
set hlsearch                  " Highlight search matches
set incsearch                 " Search as you type
set ignorecase                " Case-insensitive search
set smartcase                 " Override ignorecase when search has uppercase

" -----------------------------------------------------------------------------
" Editing behavior
" -----------------------------------------------------------------------------
set backspace=indent,eol,start " Backspace over indent, line endings, and insert start
set hidden                    " Allow switching buffers without saving
set encoding=utf-8             " Use UTF-8
set mouse=a                   " Enable mouse (scroll, resize, click)
set splitbelow                " New horizontal splits open below
set splitright                " New vertical splits open to the right
set updatetime=300            " Faster refresh for plugins (e.g. git signs)

" -----------------------------------------------------------------------------
" History & undo
" -----------------------------------------------------------------------------
set history=1000              " Command/search history
set undofile                  " Persist undo across sessions (uses .vim undodir)
if !isdirectory($HOME . "/.vim/undodir")
  call mkdir($HOME . "/.vim/undodir", "p")
endif
set undodir=~/.vim/undodir

" -----------------------------------------------------------------------------
" Syntax & file types
" -----------------------------------------------------------------------------
syntax on                     " Enable syntax highlighting
filetype on                   " Enable file type detection
filetype plugin on            " Load file-type-specific plugins
filetype indent on            " Load file-type-specific indent rules

" -----------------------------------------------------------------------------
" Key mappings (optional quality-of-life)
" -----------------------------------------------------------------------------
nnoremap <Esc><Esc> :nohlsearch<CR>   " Clear search highlight with double Escape
