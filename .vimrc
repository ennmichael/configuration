set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'preservim/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'posva/vim-vue'
Plugin 'neoclide/coc.nvim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'rhysd/vim-clang-format'
Plugin 'jparise/vim-graphql'
Plugin 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plugin 'sheerun/vim-polyglot'
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'dense-analysis/ale'
Plugin 'SirVer/UltiSnips'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'habamax/vim-godot'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"""""""" Status line settings


set laststatus=2
let g:airline_theme='bubblegum'


"""""""" Colors


colors codedark


"""""""" Terminal emulation


tnoremap š <C-\><C-n>

" Use đđ to start a terminal in insert mode
nmap đđ :terminal<CR>A
" Use ĐĐ to do that in a new window
nmap ĐĐ <C-W>n:terminal<CR>A


"""""""" Indentation settings


filetype plugin indent on
set autoindent expandtab smarttab tabstop=4 shiftwidth=4
autocmd FileType typescript,javascript,typescript.tsx,javascriptreact,typescriptreact,yaml,yml set shiftwidth=2


"""""""" Quality of life settings and keybindings


noremap <silent> <C-b> :on<CR>
set list

" Return cursor to previous position when re-opening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

nnoremap <F1> /{}<CR>a<CR><ESC>O
set nowrap
set nohlsearch
set nonu
" Remove ex mode, aka EVIL MODE
map Q <Nop>

" Execute current Python file on ćć
autocmd BufEnter *.py nmap ćć :!python3 %<CR>


"""""""" NERDTree settings


map <silent> <C-n> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen=0
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinPos="right"
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeChDirMode=2
let g:NERDTreeWinSize=55


"""""""" CoC/OmniSharp settings


let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_info = '•'
let g:ale_sign_style_error = '•'
let g:ale_sign_style_warning = '•'

let g:ale_linters = { 'cs': ['OmniSharp'] }

let g:coc_global_extensions = ["coc-json", "coc-snippets", "coc-ultisnips", "coc-rust-analyzer", "coc-tsserver", "coc-prettier"]

let g:OmniSharp_want_snippet = 1

let g:syntastic_cs_checkers = ['code_checker']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {"mode": "passive", "active_filetypes": ["cs"]}

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


"""""""" COC/OmniSharp keybindings


" Map <tab> for trigger completion, completion confirm, snippet expand and jump
" like VSCode.

inoremap <silent><expr> <TAB>
  \ pumvisible() ? coc#_select_confirm() :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" Navigating diagnostics
autocmd BufEnter * nmap <silent> <F2> <Plug>(coc-diagnostic-next)
autocmd BufEnter * nmap <silent> <F14> <Plug>(coc-diagnostic-prev)
autocmd BufEnter *.cs nmap <silent> <F2> :ALENextWrap<CR>
autocmd BufEnter *.cs nmap <silent> <F14> :ALEPreviousWrap<CR>

" GoTo code navigation.
autocmd BufEnter * nmap <silent> gd <Plug>(coc-definition)
autocmd BufEnter *.cs nmap <silent> gd <Plug>(omnisharp_go_to_definition)

autocmd BufEnter * nmap <silent> gi <Plug>(coc-implementation)
autocmd BufEnter *.cs nmap <silent> gi <Plug>(omnisharp_find_implementations)

autocmd BufEnter * nmap <silent> gr <Plug>(coc-references)
autocmd BufEnter *.cs nmap <silent> gr <Plug>(omnisharp_find_usages)

autocmd BufEnter * nmap <silent> gy <Plug>(coc-type-definition)

autocmd BufEnter * nmap <silent> ga <Plug>(coc-codeaction-line)
autocmd BufEnter *.cs nmap <silent> ga <Plug>(omnisharp_code_actions)

" Easy restarting
nmap <silent> čč :silent CocRestart<CR>

autocmd BufEnter * nmap <silent> čć :silent CocRestart<CR>
autocmd BufEnter *.cs nmap <silent> čć <Plug>(omnisharp_restart_server)

nmap čl :CocList sources<CR>

" Use K to show documentation in preview window.
autocmd BufEnter * nnoremap <silent> K :call <SID>show_documentation()<CR>
autocmd BufEnter *.cs nnoremap <silent> K :OmniSharpDocumentation<CR>

" Formatting code
autocmd BufWritePre *.cs nnoremap <silent> L :OmniSharpCodeFormat<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
autocmd BufEnter * nmap <F6> <Plug>(coc-rename)
autocmd BufEnter *.cs nmap <F6> <Plug>(omnisharp_rename)

augroup mygroup
  autocmd!
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
autocmd BufEnter * nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
autocmd BufEnter *.cs nnoremap <silent> <space>a :lopen<CR>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
autocmd BufEnter * nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
autocmd BufEnter *.cs nnoremap <space>s :OmniSharpFindSymbol 
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
