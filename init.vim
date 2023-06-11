set number relativenumber
                  " hybrid line numbering
set hidden        " hide buffers instead of closing theme
"set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set scrolloff=2   " show some context when scrolling
set list
set listchars=tab:\ \ ,trail:.,extends:#,nbsp:.

filetype plugin indent on

" appearance
set title
syntax on
colorscheme desert
autocmd InsertEnter,InsertLeave * set cul!  "highlight line when in insert mode
if !has('gui_running')
	hi Normal guibg=NONE ctermbg=NONE   "transparent bg in terminal
endif
if &term =~ "xterm\\|rxvt"
	" use a | cursor in insert mode
	let &t_SI = "\<Esc>[5 q"

	" use a rectangle cursor otherwise
	let &t_EI = "\<Esc>[1 q"
	autocmd VimEnter * silent !echo -ne "\e[1 q"
endif

set splitbelow
set splitright

" easy window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Python
au BufNewFile,BufRead *.py
	\ execute 'packadd YouCompleteMe'
	\ | set tabstop=4
	\ | set softtabstop=4
	\ | set shiftwidth=4
	\ | set textwidth=79
	\ | set expandtab

" commands
command Wc w !wc -w
