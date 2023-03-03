set nu
set encoding=utf-8
set nobackup
set nowritebackup
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

set mouse=
filetype on

lua print('this also works')
set runtimepath+=./dev/vim/lua

" session
set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize

"misc
nmap <Space>! :<C-U>FloatermNew<CR>

"navigation
"windows
"buffers
nmap <Space>b :<C-U>bp<CR>
nmap <Space>p :<C-U>bnext<CR>
nmap <Space>B :<C-U>lua require("buffer_manager.ui").toggle_quick_menu()<CR>
"tabs
nmap <Space>R :<C-U>tabNext<CR>
" nmap <S"> :<C-U>vertical resize -5<CR>
" nmap <S-+> :<C-U>vertical resize +5<CR>
"
nmap ga :GoAlternate<CR>
nmap gD :GoDefPop<CR>
nmap tf :GoTestFunc<CR>

" Markdown runner
nmap <Space>r :<C-U>MarkdownRunner<CR>

"xcplip
vnoremap <Space>Y :'<,'>:w !DISPLAY=:0 xclip -selection clipboard<CR>

"
" UML plugin
let g:preview_uml_url='http://localhost:4040'

" Tags 
nmap <Space>t :<C-U>TagbarToggle<CR>

"NerdTree
"
" nmap <Space>t :<C-U>NERDTree<CR>
nmap <Space>T :<C-U>NERDTreeToggle<CR>

"fzf config
nmap <Space>f :<C-U>FZF<CR>

"vim-go config
let g:go_test_timeout= '300s'
let g:go_test_show_name = 1
let g:go_build_tags = "integration integration_db integration_rmq fullcycle integration_testnet integration_testnet_skip"
let g:go_build_flags = '-tags="integration integration_db integration_rmq fullcycle integration_testnet integration_testnet_skip"'
let g:go_term_mode='split'


"coc config
set updatetime=300
let g:coc_config_home = "./dev/vim"
set signcolumn=yes
inoremap <silent><expr><TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

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

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"plugins
call plug#begin("./dev/vim/plugged")

" navigation

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'christoomey/vim-tmux-navigator'
Plug 'j-morano/buffer_manager.nvim'
Plug 'chentoast/marks.nvim'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'preservim/nerdtree' |
           \ Plug 'Xuyuanp/nerdtree-git-plugin' |
           \ Plug 'ryanoasis/vim-devicons'

" tabs
Plug 'gcmt/taboo.vim'
Plug 'godlygeek/tabular'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" status line
" Plug 'itchyny/lightline.vim'

" general coding plugins
Plug 'tpope/vim-commentary'
Plug 'andrewferrier/wrapping.nvim'
Plug 'tpope/vim-surround'
Plug 'neovim/nvim-lspconfig'

" Go 
Plug 'fatih/vim-go'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'hexdigest/gounit-vim'

" browser integration
Plug 'tyru/open-browser.vim'

" plantuml
Plug 'aklt/plantuml-syntax'
Plug 'skanehira/preview-uml.vim'
Plug 'weirongxu/plantuml-previewer.vim' " previewer

" markdown
Plug 'preservim/vim-markdown'

Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
Plug 'voldikss/vim-floaterm'

" themes
Plug 'Dave-Elec/gruvbox'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
" Plug 'ryanoasis/vim-devicons' Icons without colours
" Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }

" misc
Plug 'junegunn/vim-easy-align'
Plug 'nvim-lua/plenary.nvim'

" vertical block lines
Plug 'lukas-reineke/indent-blankline.nvim'

" docker
Plug 'ekalinin/Dockerfile.vim'

" icons ?
Plug 'stevearc/dressing.nvim'
Plug 'ziontee113/icon-picker.nvim'


Plug 'itchyny/calendar.vim'
Plug 'majutsushi/tagbar'

" my plugins/forks
Plug '1llusion1st/nvim-markdown-runner'
Plug '1llusion1s/nvim-jira'
Plug '1llusion1s/nvim-json2gostruct'

call plug#end()

" select the color scheme
let g:gruvbox_transparent_bg = '1'
colorscheme gruvbox

" In your init.lua or init.vim
set termguicolors
"lua << EOF
"require("bufferline").setup{}
"EOF

lua << EOF
require("icon-picker").setup({ disable_legacy_commands = true })
EOF

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }


let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 2

" Google calendar & task
" let g:calendar_google_calendar = 1
" let g:calendar_google_task = 1

" noremap <silent> {Left-Mapping} :<C-U>TmuxNavigateLeft<cr>
" noremap <silent> {Down-Mapping} :<C-U>TmuxNavigateDown<cr>
" noremap <silent> {Up-Mapping} :<C-U>TmuxNavigateUp<cr>
" noremap <silent> {Right-Mapping} :<C-U>TmuxNavigateRight<cr>
" noremap <silent> {Previous-Mapping} :<C-U>TmuxNavigatePrevious<cr>

noremap <C-h> :<C-U>TmuxNavigateLeft<cr>
noremap <C-l> :<C-U>TmuxNavigateRight<cr>
noremap <C-j> :<C-U>TmuxNavigateDown<cr>
noremap <C-k> :<C-U>TmuxNavigateUp<cr>

let g:vim_markdown_folding_disabled = 1

" marks
lua << EOF
require'marks'.setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { ".", "<", ">", "^" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions. 
  -- higher values will have better performance but may cause visual lag, 
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = false,
  },
  mappings = {}
}
EOF

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

lua << EOF
local lspconfig = require'lspconfig'
	lspconfig.gopls.setup{
	  -- on_attach = require'completion'.on_attach;
	  settings = { gopls =  {
	    buildFlags =  {"-tags=integration_testnet"}
	  }
	}
  }
EOF

" set modifiable
"
