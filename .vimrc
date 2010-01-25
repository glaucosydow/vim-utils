" File: .vimrc
" Author: Lucas 
" Description: My vim helpers, based on Frangossauro's .vimrc 

set nocompatible

" General
set t_Co=256
colorscheme molokai
set shm=atI                     " Disable Intro screen
set vb                		" Visual bell
""set nobk nowb noswf             " Disable backup
set lazyredraw                  " Don't update while in macro
set ttyfast                     " Improves redrawing
set title                       " Enable window title
set titlestring=%f%(\ [%M]%)    " Display filename in terminal window
set ruler                       " Show current line number on bar
""set showcmd                     " Show commands at bottom right
set showmode                    " Show current mod
set splitbelow                  " Split windows BELOW current window!
""set hidden                      " Allow hidden buffers
set complete=.,w,b,u,U,t,i,d    " Extra powerful completions :P
set modeline modelines=5        " Respect modeline if the file has one in the first 5!
set enc=utf-8                   " UTF-8 Default encoding
set number                      " Line Numbers"
""set winminheight=0              " Window minimum height
set numberwidth=1               " Line number column narrow as possible
set cpoptions+=>                " Items in register separated by newline  

"" Disable backup
set nobackup
set nowritebackup
set noswapfile

set grepprg=ack

" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" ??
set more
set report=0                    " Always report the number of lines changed
set display=lastline            " Show as much of the last line as possible 
""set ttimeoutlen=50
""set laststatus=2

" Highlight current curslor line
set cursorline                  " Show a cursor in the current line
hi CursorLine   cterm=bold
hi TabLine      cterm=bold,underline ctermfg=8 ctermbg=none
hi TabLineSel   cterm=bold ctermfg=0 ctermbg=7
hi TabLineFill  cterm=bold ctermbg=none
hi TabLine      cterm=bold,underline ctermfg=8 ctermbg=none
hi TabLineSel   cterm=bold ctermfg=0 ctermbg=7
hi TabLineFill  cterm=bold ctermbg=none

" Command-line completion
set wildmode=longest:full,list:full
set wildignore+=*.o,*.obj,*.pyc,*.DS_STORE,*.db,*.swc

" AutoComplete in Vim
set infercase
set completeopt=longest,menu
set ofu=syntaxcomplete#Complete
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Scroll
set nostartofline
set scrolloff=10         " At Least 5 lines above/below cursor

" Text formatting, identing, tabbing
set autoindent
set smarttab
""set expandtab
""set shiftround
""set shiftwidth=4
""set softtabstop=4
set nojoinspaces
set backspace=indent,eol,start          	            " Allow backspacing over anything 

" Filetype may overwrite indent options!
filetype plugin indent on

set formatoptions-=t
set formatoptions+=corqn
"                  |||||
"                  ||||+-- Recognize numbered lists
"                  |||+--- Allow formatting of comments with 'gq'
"                  ||+---- Insert comment leader after <Enter>
"                  |+----- Insert comment leader after o/O
"                  +------ Auto-wrap comments

" Folding
set foldmethod=marker
set foldcolumn=1
filetype plugin on

" Search Configuration
""set ignorecase              " make searches case-insensitive, unless they contain upper-case letters:
set incsearch               " Incremental search
set hlsearch                " Highligh searches 
""set gdefault                " Assume /g flag on :s searches

" Code configs 
syntax on
set showmatch 		 " Show matching brackets
set mat=5
set matchpairs=(:),{:},[:],<:>

"""
""" Extensions
"""

"
"" Improve Vim copy for OSX terminal 
if has('gui_running')
    set mousefocus          " Mouse can control splits
    set mouse=a

    set t_Co=256
    "colorscheme molokai 
    set gfn=Monaco:h10

    " Dont show shitty toolbar
    set go-=T to 

    " Transparency "
    "set transp=5
endif

"
" SuperTab Completion
"
let g:SuperTabDefaultCompletionType = "context"

"
" TabBar (minibufexpl++)
"
let g:Tb_SplitBelow     = 0
let g:Tb_UseSingleClick = 1

"
"" Mappings
let mapleader = ","

" Slightly more familiar indent on visual mode
vnoremap <tab>       >gv
vnoremap <s-tab>     <gv

"" Scrolling
no J 10j
no K 10k

" Increment/decrement numbers
nn = <c-a>
nn + <c-x>

nmap :W :w
nmap :Q :q
nmap :Wq :wq

map <PageDown> :call SmoothPageScrollDown()<CR> 
map <PageUp>   :call SmoothPageScrollUp()<CR> 


" Fuzzy finder
map <leader>f <ESC>:FufFile **/<CR>

" Buffer editing
nn <Leader>j       <C-W>j<C-W>_
nn <Leader>k       <C-W>k<C-W>_
nn <Leader>=       <C-W>=

" FileTree Browser
nn <Leader>d       <ESC>:NERDTreeToggle<cr>

nn <Leader>n       <ESC>:set number! number?<cr>

nn <Leader>s       <ESC>:Ack 
nn <Leader>r       <ESC>:make<Cr>
nn <Leader>o       <ESC>:make open<Cr>

" Shit, something is over my shoulder, my code
" is super secret. QUIT NOW, I REPEAT, NOW
nn <Leader>q        <ESC>:x<Cr>

" Visual mode
xno v 	<esc>
xno <Leader>=  :Align =<CR>	

" Yank to all app's
xno <Leader>y !pbcopy<cr><esc>u 
nmap <silent> <Leader>p :SmartPaste<cr>

" Fullscreen "
nmap <Leader>c :set invfullscreen<cr>:set columns=1000<cr>

" Map space key to fold/unfold!
""nnoremap <space> za
""vnoremap <space> zf

"
"" FileType shitty!
"

" ,r Save and Run the code
au FileType xhtml,xml so ~/.vim/ftplugin/html_autoclosetag.vim


" Make actionscript helpers with sprout 
au FileType actionscript set makeprg=rake
au FileType as3 set efm=%C%.%#,%E%f(%l) col %c\ Error %m
autocmd BufRead *.as set filetype=actionscript

" Interpret python code under the visual cursor 
au FileType python set makeprg=python\ %
au FileType python vnoremap ,r :!python<cr> 

" Waf scripts recognition
au BufNewFile,BufRead wscript set syntax=python

" Make sure paste mode is on before pasting
function! SmartPaste()
    set paste
    normal! p`[=`]
    set nopaste
endfunction
command! -bar SmartPaste :call SmartPaste()

" Fix the search in visual mode.
" Only search the selected text
vnoremap /          <Esc>/\%V

" Avoid some stupid typing when substituing 
" variables in visual mode
vnoremap r          <Esc>:'<,'>B s/\<.*\>/