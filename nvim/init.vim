" set line numbers
set number relativenumber

" Install vim-plug if not already installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" List of plugins managed by vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Install the Dracula color scheme
Plug 'dracula/vim'
" Coc Plugins
" Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'nvim-lua/plenary.nvim'
" NERDTree file browser
Plug 'preservim/nerdtree'
" fzf for directory jumping using NERDTree
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-rust-analyzer', {'github': 'justinkambic', 'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-clangd', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript']
  \ }

" End of plugin list
call plug#end()

" Set the color scheme to Dracula
colorscheme dracula

" Use <Tab> and <S-Tab> to navigate through popup menu items
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <CR> to confirm completion and close the popup menu
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Use <C-Space> to trigger completion
inoremap <silent><expr> <C-Space> coc#refresh()

" Use <C-c> to stop completion and close the popup menu
inoremap <silent><expr> <C-c> coc#_cancel()

let g:coc_global_extensions = ['coc-snippets', 'coc-tsserver', 'coc-json', 'coc-rust-analyzer', 'coc-clangd', 'coc-css', 'coc-html']

" Remap copy current file path
nnoremap <Leader>cf :let @+ = expand('%:p')<CR>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Customize coc-clangd diagnostics highlighting
highlight CocErrorSign ctermfg=15 ctermbg=1 guifg=#ffffff guibg=#ff0000
highlight CocWarningSign ctermfg=15 ctermbg=3 guifg=#ffffff guibg=#ffff00
highlight CocErrorFloat ctermfg=15 ctermbg=1 guifg=#ffffff guibg=#ff0000
highlight CocWarningFloat ctermfg=15 ctermbg=3 guifg=#ffffff guibg=#ffff00

set clipboard=unnamedplus

" Open Telescope file picker
nnoremap <leader>ff <cmd>Telescope find_files<cr>

" Open Telescope live grep
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

" Open Telescope buffers
nnoremap <leader>fb <cmd>Telescope buffers<cr>

" Open Telescope git files
nnoremap <leader>f <cmd>Telescope git_files<cr>

" Open Telescope live_grep
nnoremap <leader>lg <cmd>Telescope live_grep<CR>

" Open NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" enable fzf fuzzy searching in NERDTree
let g:NERDTreeFindFuzzy = 1
"
" Automatically expand NERDTree and highlight the current file's path
"autocmd BufEnter * if (exists("g:NERDTree") && isdirectory(expand("%:p:h"))) | 
"NERDTreeFind | endif

" custom workspace typescript config for Kibana
autocmd BufEnter,BufWinEnter,TabEnter *.ts,*.tsx call SetTsdk()
function! SetTsdk()
  if expand('%:p:h') =~# '/Users/jk/git/justinkambic/kibana'
    let g:coc_local_config = {'tsserver.tsdk': '/Users/jk/git/justinkambic/kibana/node_modules/typescript'}
"  use this for other custom workspace configs
"  elseif expand('%:p:h') =~# '/path/to/workspace2'
"    let g:coc_local_config = {'tsserver.tsdk': '/path/to/typescript-2'}
  else
    " Default TypeScript version or fallback behavior
    let g:coc_local_config = {'tsserver.tsdk': 'default'}
  endif
endfunction

" Enable formatting on save
autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx PrettierAsync

