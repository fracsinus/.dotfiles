call plug#begin('~/.vim/plugged')

Plug 'justinmk/vim-dirvish' " use - to initiate path navigator (using arrow keys)
Plug 'christoomey/vim-tmux-navigator' " use C-h,j,k,l to navigate across vim and tmux panes
Plug 'chrisbra/Recover.vim' " smarter .swp files recovery
Plug 'tpope/vim-surround' " use s to indicate surroundings(e.g. quotation marks or parentheses)
Plug 'tpope/vim-commentary' " use gc~ to turn current line into a comment
Plug 'tpope/vim-eunuch' " use :Rename and :Delete to rename or to delete a file within vim
Plug 'tpope/vim-repeat' " use . to repeat action
Plug 'kien/ctrlp.vim' " use C-p to initiate path finder (using path input)
Plug 'junegunn/fzf.vim' "
Plug 'udalov/kotlin-vim'
Plug 'altercation/vim-colors-solarized'


call plug#end()


set hlsearch " highlight text while searching
set incsearch " use incremental searching
set ttimeoutlen=0 " remove interval when press esc

" adjust indentation to two spaces globally
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
sy enable
set nocin nosi inde=
" set autoindent
" set smartindent
filetype plugin indent on " about indentation settings for different filetypes, check ~/.vim/after/ftplugin/<filetype>.vim

" Ctrl-s to save in both normal and insert mode
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

" K to remove highlights
nnoremap K :noh<CR>
" Alt+Backspace to remove a previous word
inoremap <A-BS> <C-w>

" for gvim
" F2 to open
nnoremap <F2> :browse confirm e<CR>
" F3 to vertical split-open
nnoremap <F3> :browse vsp<CR>
" Shift+F3 to horizontal split-open
nnoremap <S-F3> :browse sp<CR>
" F4 to tab-open
nnoremap <F4> :browse tabnew<CR>
" F5 to open an empty tab
nnoremap <F5> :tabnew<CR>

nnoremap <CR> G

" w!! to write as root
cmap w!! %!sudo tee > /dev/null %

set nu

syntax enable
set background=light
colorscheme solarized

" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

set splitright
set splitbelow

" Prevent vim from clearing the terminal
"set t_te=
"set t_ti=

" Restore the last editing position
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" file encodings
set fencs=ucs-bom,utf-8,cp949

" Set color of ColorColumn
highlight ColorColumn ctermbg=7
highlight LineNr ctermbg=7

" for *.py files, highlight 80th
autocmd FileType python setlocal colorcolumn=80

" for *.py files, disable double indentation after a open parenthesis
let g:pyindent_open_paren = 'shiftwidth()'

" (Visual) Ctrl+c to copy into clipboard register
vnoremap <C-c> "+y
language messages en_US
