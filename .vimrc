call plug#begin()
Plug 'fatih/vim-go'
Plug 'AndrewRadev/splitjoin.vim' "Split/Join
Plug 'SirVer/ultisnips' "Snippet
Plug 'fatih/molokai'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'jstemmer/gotags'
Plug 'majutsushi/tagbar'
call plug#end()

" Switch leader from \ to ,
let mapleader = ","
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
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

let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_def_mode = 'godef' 

let g:go_auto_type_info = 1
set updatetime=100
let g:go_auto_sameids = 1

"Auto save file for execution i.e. GoBuil, GoTest
set autowrite
set number
set relativenumber

syntax enable
filetype plugin on
let g:neocomplete#enable_at_startup = 1
nmap <F9> :TagbarToggle<CR>

" Move between errors
map <F2> :cnext<CR>
map <F3> :cprevious<CR>
map <F7> :tabp<CR>
map <F8> :tabn<CR>

" Go short-cuts
"autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
"autocmd FileType go nmap <leader>l <Plug>(golint)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')



" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
 let l:file = expand("%")
 if l:file =~# '^\f\+_test\.go$'
   call go#test#Test(0, 1)
 elseif l:file =~# '^\f\+\.go$'
   call go#cmd#Build(0)
 endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

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
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


map <C-a> :call Comment()<CR>
map <C-b> :call Uncomment()<CR>

function! Comment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py' || ext == 'yml' || ext == 'toml'
    silent s/^/\#/
  elseif ext == 'js'
    silent s:^:\/\/:g
  elseif ext == 'vim'
    silent s:^:\":g
  endif
endfunction

function! Uncomment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py' || ext == 'yml' || ext == 'toml'
    silent s/^\#//
  elseif ext == 'js'
    silent s:^\/\/::g
  elseif ext == 'vim'
    silent s:^\"::g
  endif
endfunction
