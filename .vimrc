call plug#begin()
Plug 'fatih/vim-go' "Go Plugin
Plug 'AndrewRadev/splitjoin.vim' "Split/Join
Plug 'SirVer/ultisnips' "Snippet
Plug 'fatih/molokai' "Monokai Theme
Plug 'scrooloose/nerdtree' "File Tree View
Plug 'ctrlpvim/ctrlp.vim' "File Finder
Plug 'Shougo/neocomplete.vim' "Keyword Completion
Plug 'majutsushi/tagbar' "File Tag Overview
Plug 'jstemmer/gotags' "TagBar Golang Generator
call plug#end()


" Molokai config
let g:molokai_original = 1
let g:rehash256 = 1
" Auto save file for execution i.e. GoBuil, GoTest
set autowrite
" Show row number
set number
" Show relative number 
set relativenumber
" Detect plugin for filetype
filetype plugin on
" Type autocomplete
let g:neocomplete#enable_at_startup = 1

" Move between go errors
nmap <F2> :cnext<CR>
nmap <F3> :cprevious<CR>
" Tab next and previous
nmap <F7> :tabp<CR>
nmap <F8> :tabn<CR>
" Plugin toggle
nmap <C-n> :NERDTreeToggle<CR>
nmap <F9> :TagbarToggle<CR>

" Tab spacing configuration
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.yml setlocal noexpandtab tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.yaml setlocal noexpandtab tabstop=2 shiftwidth=2

" Go short-cuts
"autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
"autocmd FileType go nmap <leader>l <Plug>(golint)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
"autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" Switch leader from \ to ,
let mapleader = ","
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1

" Go syntax highlights
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

" Go Lint config
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_def_mode = 'godef' 

let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
 let l:file = expand("%")
 if l:file =~# '^\f\+_test\.go$'
   call go#test#Test(0, 1)
 elseif l:file =~# '^\f\+\.go$'
   call go#cmd#Build(0)
 endif
endfunction


" TagBar implmenetation with custom gotags directory
let g:go_gotags_bin = '~/go/bin/gotags'
let ctagsbin = expand(g:go_gotags_bin)
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : ctagsbin,
    \ 'ctagsargs' : '-sort -silent'
\ }

" Multi-row comment shortcuts
map <C-a> :call Comment()<CR>
map <C-b> :call Uncomment()<CR>

function! Comment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py' || ext == 'yml' || ext == 'toml'
    silent s/^/\#/
  elseif ext == 'js' || ext == 'go'
    silent s:^:\/\/:g
  elseif ext == 'vim'
    silent s:^:\":g
  endif
endfunction

function! Uncomment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py' || ext == 'yml' || ext == 'toml'
    silent s/^\#//
  elseif ext == 'js' || ext == 'go'
    silent s:^\/\/::g
  elseif ext == 'vim'
    silent s:^\"::g
  endif
endfunction
