set modeline
set number relativenumber
                  " hybrid line numbering
"set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
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

set timeoutlen=1000
set ttimeoutlen=5

" appearance
set title
syntax on
colorscheme desert
autocmd InsertEnter,InsertLeave * set cul!  "highlight line when in insert mode
if !has('gui_running')
	hi Normal guibg=NONE ctermbg=NONE   "transparent bg in terminal
endif
"if &term =~ "xterm\\|rxvt"
	" use a | cursor in insert mode
"	let &t_SI = "\<Esc>[6 q"

	" use a rectangle cursor otherwise
"	let &t_EI = "\<Esc>[2 q"
	"autocmd VimEnter * silent !echo -ne "\e[2 q"
"endif

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
function RichPaste()
	let extension = expand('%:e')
	let cmd = "xclip -o -sel c -t text/html"
	if extension == "md"
		let cmd = cmd . " | pandoc -f html -t gfm-raw_html"
	elseif extension == "tex"
		let cmd = cmd . " | pandoc -f html+smart -t latex"
	endif
	let out = system(cmd)
	put =out
endfunction
command Rp call RichPaste()
function RichYankDocument(plain)
	let extension = expand('%:e')
	if extension == "tex"
		let type = "latex"
	else
		let type = "markdown"
	endif
	let cmd = "silent w !pandoc -f " . type . " -t html | xclip -i -sel c"
	if a:plain == 0
		let cmd = cmd . " -t text/html"
	endif
	exe cmd
endfunction
command RY call RichYankDocument(0)
command RYP call RichYankDocument(1)
function RenderDocument(out_ext)
	let in_file_name = expand('%:p')
	let g:out_file_name = expand('%:p:r') . "." . a:out_ext
	exe "!pandoc -s -V boxlinks=true -V geometry:margin=0.79in -o '" . g:out_file_name . "' '" . in_file_name . "' && echo Done."
endfunction
command! -nargs=1 R call RenderDocument(<f-args>)
command Ro let _ = system("xdg-open '" . g:out_file_name . "' &")
command Rpy let @+ = g:out_file_name
