"  MS-DOS and Win32:  $VIM\_vimrc for OpenVMS:  sys$login:.vimrc

" tipps

" :h rename-files

" opens buffer in split
" :sbuffer N 

" change window placement 
" C^W H
" C^W L

" jump list: go back where you are
" ^o 
" ^i
" show jump list:
" :jumps
" :ju       

" jump to last changes
" :changes
" going back in the change list:
" g;
" going forward in the change list:
" g,

" open N-th buffer split " :vsp | b N " delete tab " :bd :bdel :bdelete " Browser confirm open " :bro confirm e " select word under the cursor " viw

" copy word under the cursor
" yiw

" eine Datei in einem neuen tab öffnen
" :browse tabenew

"Close buffer/window
" ^W c

" delete buffer
" :bd

" The sb command normally opens the given buffer in a new split window, but the tab command causes it to open in a new tab, instead.
" tab sb N
" -------------------------------------------------------------------------------- 
" source $VIMRUNTIME/vimrc_example.vim

" turn on relative numbers
set rnu

" Set the syntax highlighting of specific filetypes
autocmd BufRead,BufNewFile *.{mmd,md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
autocmd BufRead,BufNewFile *.{xdml} set filetype=xml
autocmd BufRead,BufNewFile *.{log} set filetype=log
au BufNewFile,BufRead *.iwaylog set filetype=iwaylog

" change automatically the working directory to the directory of the working file
autocmd BufEnter * silent! lcd %:p:h

" https://github.com/MTDL9/vim-log-highlighting
" Add custom level identifiers
"syn keyword logLevelError MY_CUSTOM_ERROR_KEYWORD
"
"
"-------------------------------------------------------------------------------- 

" This workaround seems to work (mind the capitalized T in the end):
autocmd FileType qf nnoremap <buffer> <Enter> <C-W><Enter><C-W>T

" It will create a mapping that is local to the quickfix buffer (it also works in location lists, since they have the same 
" filetype, i.e. qf). 
" This mapping will first open the item under the cursor in a new window using <C-W><Enter> 
" and then move it to an new tab using <C-W>T.
"See
"
":help :autocmd
":help quickfix
":help CTRL-W_<Enter>
":help CTRL-W_T
" ---------------------------------------------------------------------

" change the mapleader from \ to -
let mapleader=","

" center next search result
nmap N Nzz
nmap n nzz

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" Source vimrc with <Leader>vc
nnoremap <Leader>vc :source $MYVIMRC<CR>:echo "Reloaded _vimrc"<CR>
" Add a semicolon to the current line without moving the cursor with <Leader>;
nnoremap <Leader>; m'A;<ESC>`'
" Clear trailing whitespace with <Leader>cw
nnoremap <Leader>cw :%s/\s\+$//g<CR>:nohlsearch<CR>
"next window in buffer
nnoremap <Leader>n :bnext<CR>
"previous window in buffer
nnoremap <Leader>N :bprev<CR>

" spelling
nnoremap <Leader>s1 :setlocal spell spelllang=en_us<CR>
nnoremap <Leader>s2 :set spell spelllang=en_us<CR>
nnoremap <Leader>sn :set nospell<CR>

" open file
nnoremap <Leader>e :bro confirm e<CR>
nnoremap <Leader>t :bro tabnew<CR>

set guifont=Consolas:h12:cANSI
" The encoding displayed.
set encoding=utf-8  
" The encoding written to file.
set fileencoding=utf-8  

" color setting
colors slate
" colors jellybeans
" colors yin

" initial size 
":set lines=50 columns=130

"nuse perl regexes - src: http://andrewradev.com/2011/05/08/vim-regexes/
noremap / /\v

" omit a dir from all searches to perform globally 
set wildignore+=**/node_modules/** 

" autoupdate file
set autoread

" Compatible mode means compatibility to venerable old vi. When you :set compatible, all the enhancements and improvements of Vi Improved are turned off.
set nocompatible

" search as characters are entered, as you type in more characters, the search is refined 
" Searching.
" highlight matches, in normal mode try typing * or even g* when cursor on string 
set incsearch ignorecase smartcase 

" start at the beginning of the file when hit the end of the file
set wrapscan

set history=1000
set undolevels=1000
set title
set visualbell
set noerrorbells

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" syntax on filetype plugin on
set path+=** 
set wildmenu

" menu bar 
set guioptions+=m  
" include toolbar
set guioptions+=T  
""scrollbar
set number    

" temporary files
"if isdirectory($TMP .'vim') == 0 
"  :silent !md \%TMP\%\\vim
"endif

" backup directory
"set undodir=%TMP%\vim
"set directory=%TMP%\vim
"set backupdir=%TMP%\vim

"fun! InitBex()
 "let myvar = strftime("%y%m%d_%Hh%M")
 "let myvar = "set backupext=_". myvar
 "execute myvar
 "echo myvar
"endfun
"map <Esc> :call InitBex()<CR>

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

if has ('gui_running')
	set guifont=Consolas:h9:cANSI:qDRAFT
endif

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Consolas\ 12
  elseif has("gui_win32")
    set guifont=Consolas:h12:cANSI
  endif
endif

function! ShowFunc(sort)
  let gf_s = &grepformat
  let gp_s = &grepprg
  if ( &filetype == "c" || &filetype == "php" || &filetype == "python" ||
    \ &filetype == "sh" )
    let &grepformat='%*\k%*\sfunction%*\s%l%*\s%f %m'
    let &grepprg = 'ctags -x --'.&filetype.'-types=f --sort='.a:sort
  elseif ( &filetype == "perl" )
    let &grepformat='%*\k%*\ssubroutine%*\s%l%*\s%f %m'
    let &grepprg = 'ctags -x --perl-types=s --sort='.a:sort
  elseif ( &filetype == "vim" )
    let &grepformat='%*\k%*\sfunction%*\s%l%*\s%f %m'
    let &grepprg = 'ctags -x --vim-types=f --language-force=vim --sort='.a:sort
  endif
  if (&readonly == 0) | update | endif
  silent! grep %
  cwindow 10
  redraw
  let &grepformat = gf_s
  let &grepprg = gp_s
endfunc

" Show file browser
nmap <F1> :Sex<CR>

" Show function list
nmap <F2> <Esc>:call ShowFunc("no")<CR><Esc>

" Search the word under the cursor in forward direction
" nmap <F3> *
nmap <F3> :execute lvim <cword> <Bar> lopen<CR>

" Search the word under the cursor in backward direction
nmap <F4> #

" Search the word under the cursor recursively in all *c/*h files in the current directory
"nmap <F5> :execute "vimgrep /\\<" . expand("<cword>") . "\\>/j **/*.c **/*.h"<Bar> cope<CR>
nmap <F5> :execute "vimgrep /\\<" . expand("<cword>") . "\\>/j **/*"<Bar> cope<CR>

" Jump to tag
nmap <F6> <C-]>

" Jump to ambiguous tag
nmap <F7> g<C-]>

" Jump back the tag stack
nmap <F8> <C-t>

" If you prefer to open a new tab instead of a new split window, you can set switchbuf to usetab,newtab. 
" set switchbuf=usetab
" With the following you can switch to the next buffer by pressing F9, or the previous buffer by pressing Shift-F9. If the target buffer is already displayed in a window in one of the tabs, that window will be displayed. Otherwise, the current window will be split, and the target buffer will be displayed in the new window. 
nmap <F9> :bnext<CR>
nmap <S-F9> :bprevious<CR>

" show next buffer in split mode 
nmap <C-F9> :sbnext<CR>
nmap <S-F9> :sbprevious<CR>

" Create tag file
nmap <F11> :!ctags -R .<CR>

" Reformat current buffer using formatprg
nmap <F12> gggqG

" split 
nnoremap <silent> vv <C-w>v

" search word under the cursor
nnoremap <silent> K :vim /<cword>/ % \| copen<CR>

" movement between windows
nnoremap <C-h> <C-w>h 
nnoremap <C-j> <C-w>j 
nnoremap <C-k> <C-w>k 
nnoremap <C-l> <C-w>l

"nnoremap <S-h> :vertical resize -1<CR> 
"nnoremap <S-j> :resize -1<CR> 
"nnoremap <S-k> :resize +1<CR> 
"nnoremap <S-l> :vertical resize +1<CR>

    " yank those cheat commands, in normal mode type q: than p to paste in the
    " opened cmdline how-to search for a string recursively :grep!
    " "\<doLogErrorMsg\>" . -r
    "
    " how-to search recursively , omit log and git files :vimgrep /srch/ `find .
    " -type f \| grep -v .git \| grep -v .log` :vimgrep /srch/ `find . -type f
    "  -name '*.pm' -o -name '*.pl'`
    "
    " how-to search for the "srch" from the current dir recursively in the shell
    " vim -c ':vimgrep /srch/ `find . -type f \| grep -v .git \| grep -v .log`'
    "
    " how-to highlight the after the search the searchable string in normmal
    " mode press g* when the cursor is on a matched string

    " how-to jump between the search matches - open the quick fix window by
    " :copen 22

    " how-to to close the quick fix window :ccl

    " F5 will find the next occurrence after vimgrep map <F5> :cp!<CR>

    " F6 will find the previous occurrence after vimgrep map <F6> :cn!<CR>

    " F8 search for word under the cursor recursively , :copen , to close ->
    " :ccl nnoremap <F8> :grep! "\<<cword>\>" . -r<CR>:copen 33<CR>

" Save file with Control S in different modes
nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>

" Reload buffer in different modes
" nmap <F2> :update<CR>
" vmap <F2> <Esc><F2>gv
" imap <F2> <c-o><F2>

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Mnemonic: Copy File path
nnor <Leader>cf :let @*=expand("%:p")<CR>  
" Mnemonic: Yank File path
nnor <Leader>yf :let @"=expand("%:p")<CR>   
" Mnemonic: yank File Name
nnor <Leader>fn :let @"=expand("%")<CR>      


"""""" EDITOR
" Indentation and tabs.
set autoindent smartindent cindent smarttab expandtab
set copyindent
set tabstop=4 softtabstop=2 shiftwidth=4 shiftround
set linebreak backspace=indent,eol,start
" Folding.
set foldcolumn=1 foldenable foldmethod=indent foldnestmax=3 foldlevel=9
"set wrapscan magic gdefault
" Completion.
set completeopt=menuone,menu,longest,preview
set formatoptions-=cro

set showmatch

highlight Cursor guifg=black guibg=white
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver25-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait5

" whole line is highlighted during editing
set cursorline 
"set shiftwidth=2
set wrap!
"set textwidth=80 

" marks
" 
"A mark allows you to record your current position so you can return to it later. There is no visible indication of where marks are set. 
"Each file has a set of marks identified by lowercase letters (a-z). In addition there is a global set of marks identified by uppercase letters (A-Z) that identify a position within a particular file. For example, you may be editing ten files. Each file could have mark a, but only one file can have mark A. 
"Because of their limitations, uppercase marks may at first glance seem less versatile than their lowercase counterpart, but this feature allows them to be used as a quick sort of "file bookmark." For example, open your .vimrc, press mV, and close Vim. The next time you want to edit your .vimrc, just press 'V to open it. This assumes that you have kept the default 'viminfo' behavior, so that uppercase marks are all remembered in the viminfo-file between Vim sessions. 
"As well as the letter marks, there are various special marks. 
"The marks for recently-edited files are saved (provided the 'viminfo' option has the ' parameter), so marks from previous sessions can be used when editing in the future. :help 'viminfo' 
"Contents
"
"Setting marks
"
"To set a mark, type m followed by a letter. For example, ma sets mark a at the current position (line and column). If you set mark a, any mark in the current file that was previously identified as a is removed. If you set mark A, any previous mark A (in any file) is removed. 
"Using marks
"
"To jump to a mark enter an apostrophe (') or backtick (`) followed by a letter. Using an apostrophe jumps to the beginning of the line holding the mark, while a backtick jumps to the line and column of the mark. 
"Using a lowercase letter (for example `a) will only work if that mark exists in the current buffer. Using an uppercase letter (for example `A) will jump to the file and the position holding the mark (you do not need to open the file prior to jumping to the mark). 
"	• Each file can have mark a – use a lowercase mark to jump within a file. 
"	• There is only one file mark A – use an uppercase mark to jump between files. 
"	Command 	Description 
"	ma 	set mark a at current cursor location 
"	'a 	jump to line of mark a (first non-blank character in line) 
"	`a 	jump to position (line and column) of mark a 
"	d'a 	delete from current line to line of mark a 
"	d`a 	delete from current cursor position to position of mark a 
"	c'a 	change text from current line to line of mark a 
"	y`a 	yank text to unnamed buffer from cursor to position of mark a 
"	:marks 	list all the current marks 
"	:marks aB 	list marks a, B 
"Commands like d'a operate "linewise" and include the start and end lines.
"Commands like d`a operate "characterwise" and include the start but not the end character. 
"It is possible to navigate between lowercase marks: 
"Command 	Description 
"]' 	jump to next line with a lowercase mark 
"[' 	jump to previous line with a lowercase mark 
"]` 	jump to next lowercase mark 
"[` 	jump to previous lowercase mark 
"The above commands take a count. For example, 5]` jumps to the fifth mark after the cursor. 
"Special marks
"Vim has some special marks which it sets automatically. Here are some of the most useful: 
"Command 	Description 
"`. 	jump to position where last change occurred in current buffer 
"`" 	jump to position where last exited current buffer 
"`0 	jump to position in last file edited (when exited Vim) 
"`1 	like `0 but the previous file (also `2 etc) 
"'' 	jump back (to line in current buffer where jumped from) 
"`` 	jump back (to position in current buffer where jumped from) 
"`[ or `] 	jump to beginning/end of previously changed or yanked text 
"`< or `> 	jump to beginning/end of last visual selection 
"See the full list at :help '[ and following. 
"Deleting marks
"
"If you delete a line containing a mark, the mark is also deleted. 
"If you wipeout a buffer (command :bw), all marks for the buffer are deleted. 
"The :delmarks command (abbreviated as :delm) may be used to delete specified marks. 
"Command 	Description 
":delmarks a 	delete mark a 
":delmarks a-d 	delete marks a, b, c, d 
":delmarks abxy 	delete marks a, b, x, y 
":delmarks aA 	delete marks a, A 
":delmarks! 	delete all lowercase marks for the current buffer (a-z) 
"See also
"	• showmarks plugin to put a sign in the left margin for each mark; works poorly and interferes with other commands in Vim 7 (updated version working in 7.4 here: [1]) 
"	• script#2142 is another showmarks plugin which works without problems in Vim 7 
"References
"• :help mark-motions 
"Comments
"
"The :delmarks command requires Vim 7.0. On previous versions, a kludge to remove all marks is to enter the command :%!cat (on Unix-based systems), or :%!type (on Windows) to delete the entire contents of the buffer and replace each line with itself by filtering through an external command. A mark is automatically deleted when its line is deleted. 
"
"I suggest moving the Deleting section below the Using section. (Spiiph 11:53, 30 July 2009 (UTC)) 
"		I was scratching my head wondering why I put them in their current order, but when I went to move it, I see why. It's nice that "Using" and "Special" can be seen together, on the same screen because they are the items that a reader will probably want to refer to (it's a bit hard to keep all of it in your mind). I suppose "Deleting" could go after "Special", but that might be as strange as where it is now? JohnBeckett 23:34, 30 July 2009 (UTC) 
"				I think that would be better, even though it might seem illogical. Another idea would be to remove the section on Deleting marks altogether. I don't think I have ever used that functionality, and users who need it are probably advanced enough to find the information in the :help. (Spiiph 13:39, 2 August 2009 (UTC)) 
"						Done. 
"
"From <https://vim.fandom.com/wiki/Using_marks> 
"
"-------------------------------------------------------------------------------- 
