if v:progname =~? "evim"
  finish
endif

source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		
else
  set backup		
  if has('persistent_undo')
    set undofile	
  endif
endif

if &t_Co > 2 || has("gui_running")
  set hlsearch
endif

augroup vimrcEx
  au!

  autocmd FileType text setlocal textwidth=78
augroup END


if has('syntax') && has('eval')
  packadd! matchit
endif

call plug#begin()
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'vim-airline/vim-airline'
call plug#end()

" Basic settings
set number
set splitbelow
set splitright
set clipboard=unnamedplus

" Catppuccino
set termguicolors
colorscheme catppuccin_macchiato

" Airline
let g:airline_powerline_fonts = 1
