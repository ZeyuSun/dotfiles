""""""""""""""""""""""
" SPADA machine setup
""""""""""""""""""""""
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'junkblocker/git-time-lapse'
Plugin 'tmhedberg/SimpylFold'
Plugin 'maverickg/stan.vim'
Plugin 'gabrielelana/vim-markdown'
Plugin 'powerman/vim-plugin-AnsiEsc'
Plugin 'scrooloose/nerdtree'
"Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'endel/vim-github-colorscheme'
Plugin 'tpope/vim-surround'
Plugin 'davidhalter/jedi-vim'
Plugin 'will133/vim-dirdiff'
"Plugin 'chrisbra/recover.vim' # doesn't work
"Plugin 'lornix/vim-scrollbar' #doesn't work properly
Plugin 'JuliaEditorSupport/julia-vim'
"Plugin 'chrisbra/Recover.vim'
Plugin 'chrisbra/csv.vim'
" ...

"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" YAML indentation
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" vim-surround setup
let b:surround_{char2nr('b')} = "**\r**"

" Jedi-vim setup
"map <C-M> <Nop> "<C-M> binds with Enter in insert mode, remap it will also affect Enter
"<C-.> <C-E> doesn't work
"<C-P> works, but in reverse order
"So I mapped <C-N>. Use <C-P> if you want vim builtin complete
let g:jedi#completions_command = "<C-N>" 
let g:jedi#popup_on_dot = 0 "otherwise it's slow
let g:jedi#popup_select_first = 1
set noshowmode "for command line call signature to work
let g:jedi#show_call_signatures = "0" "2 doesn't always work, and will halt a few secs after I type each character of (',') in `string.split(',')`

" Open NERDTree upon open vim
"autocmd VimEnter * NERDTree # Please wait, cacheing a large directory...
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "close vim if the only window left is a NERDTree
map <C-n> :NERDTreeToggle<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
"let g:airline_powerline_fonts = 1

let g:airline_theme='cobalt2'

set hidden "Otherwise can't leave buffer using :bp :bn without saving
set laststatus=2
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-k> :bp\|bd #<CR>
"bp<cr> bdelete #<CR> "workaround to prevent current window from closing

" Enable folding
set foldmethod=indent
set foldlevel=99 "Comment this to closed all folds on opening
" Use `set foldlevel=0` to collapse all top functions/classes. Or just use z-M
nnoremap <space> za

" Auto wrap CRLF (not recommended)
"set wrap

"""""""""""""""""""""""
" My own setup
"""""""""""""""""""""""
set nu
"set relativenumber "not good for locating the line when debugging
set hls
set shortmess-=S "Search count
"set hi Search cterm=NONE ctermfg=black ctermbg=blue "colorscheme default doesn't have fg set. See $VIMRUNTIME/colors/default.vim
hi Search ctermfg=Black
hi Folded ctermbg=253
set ignorecase
" Diff highlighting with github colorscheme
hi DiffAdd    ctermfg=233 ctermbg=194 guifg=#003300 guibg=#DDFFDD gui=none cterm=none
hi DiffChange ctermbg=255  guibg=#ececec gui=none   cterm=none
hi DiffText   ctermfg=233  ctermbg=189  guifg=#000033 guibg=#DDDDFF gui=none cterm=none
hi DiffDelete ctermfg=252 ctermbg=224   guifg=#DDCCCC guibg=#FFDDDD gui=none    cterm=none
" Change default pink popup menu color.
highlight Pmenu ctermbg=gray guibg=gray

" Show existing tab with 4 spaces width
set tabstop=4
" When indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Backspace tab
set softtabstop=4
set cindent
set cinkeys-=0#
set indentkeys-=0#
set indentkeys-=: "Prevent autoindent after typing a colon. See https://stackoverflow.com/questions/19320747/prevent-vim-from-indenting-line-when-typing-a-colon-in-python
" Doesn't seem to work: e.g.: <code> # TODO:

set splitright

" Auto CRLF
"set textwidth=79

" Tlist
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
"let Tlist_Auto_Open = 1
" http://www.cnblogs.com/ifys/archive/2010/10/24/1860610.html

"""""""""""""""""""""""
" Google Cloud
"""""""""""""""""""""""
syntax on " napoli seems not working

set wildmenu

"clipboard
set clipboard=exclude:.* "do not try to connect X server which cause slow start
"set clipboard=unnamedplus # can't paste: nothing in register + 
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
set backspace=indent,eol,start "  # By default you can't backspace over auto-indentation, previous edits or line breaks.

"highlight word under cursor
"nmap <Leader>* ``
"nnoremap * *``cgn
nnoremap <silent> * :execute "normal! *N"<cr>
nnoremap <silent> # :execute "normal! #n"<cr>

" csv
let g:csv_highlight_column = 'y'