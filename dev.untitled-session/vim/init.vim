set nu
set nocompatible
set encoding=utf-8
set nobackup
set nowritebackup
set foldcolumn=2
set guioptions-=e
set sessionoptions+=tabpages,globals

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

lua vim.g.loaded_netrw = 1
lua vim.g.loaded_netrwPlugin = 1

set mouse=
filetype on

lua print('this also works')
set rtp +=~/.vim
set runtimepath+=./dev/vim/lua
set runtimepath+=./dev/vim

let g:debug_print = 0

set foldcolumn=2

" session
set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize

"misc
nmap <Space>! :<C-U>FloatermNew<CR>

"navigation
"windows
"buffers

nmap <Space>b :<C-U>bp<CR>
nmap <Space>p :<C-U>bnext<CR>
" nmap <Space>B :<C-U>lua require("buffer_manager.ui").toggle_quick_menu()<CR>
nmap <Space>F :<C-U>:Files<CR>
nmap <Space>B :<C-U>:Buffers<CR>
"tabs
nmap <Space>R :<C-U>tabp<CR>
nmap <Space>N :<C-U>tabn<CR>
" let g:nerdtree_tabs_meaningful_tab_names=1
" let g:taboo_tabline=0
" let g:airline#extensions#tabline#enabled = 1
" function! CondensedPath() abort
"     if expand(':h') == '/'
"         return '/' . expand('%:t')
"     else
"         return pathshorten(expand('%:h')) . '/' . expand('%:t')
"     endif
" endfunction

" let g:airline_section_c='%{CondensedPath()}'


nmap <Space>h :MarkdownRunnerInsert<CR>
" nmap <S"> :<C-U>vertical resize -5<CR>
" nmap <S-+> :<C-U>vertical resize +5<CR>
"
nmap ga :GoAlternate<CR>
nmap gB :GoDefPop<CR>
nmap tf :GoTestFunc<CR>

" markdown preview config
let g:mkdp_filetypes = ['markdown']
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
   \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" Markdown runner
nmap <Space>r :<C-U>MarkdownRunner<CR>

"xcplip
vnoremap <Space>Y :'<,'>:w !DISPLAY=:0 xclip -selection clipboard<CR>

"
" UML plugin
let g:preview_uml_url='http://localhost:4040'

" d2 config
"
  let g:d2_block_string_syntaxes = {
        \ 'd2': ['d2'],
        \ 'markdown': ['md', 'markdown'],
        \ 'javascript': ['javascript', 'js'],
        \ 'html': ['html'],
        \ 'json': ['json'],
        \ 'c': ['c'],
        \ 'go': ['go'],
        \ 'sh': ['sh', 'ksh', 'bash'],
        \ 'css': ['css'],
        \ 'vim': ['vim'],
        \ }

" Tags 
"

lua << EOF
function show_tags_or_toc()
  -- print(vim.bo.filetype)
  if vim.bo.filetype == 'qf' then
    vim.cmd('q')
  elseif vim.bo.filetype == 'markdown' then
    vim.cmd('Toc')
  else
    vim.cmd('Tagbar')
  end
end

EOF

nmap <Space>t :<C-U>lua show_tags_or_toc()<CR>

autocmd FileType qf nnoremap q : q<CR>

"NerdTree
"
" nmap <Space>t :<C-U>NERDTree<CR>
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeGitStatusShowClean = 1 " default: 0

"fzf config
nmap <Space>f :<C-U>FZF<CR>

"vim-go config
let g:go_test_timeout= '300s'
let g:go_test_show_name = 1
let g:go_build_tags = "integration integration_db integration_rmq fullcycle integration_testnet integration_testnet_skip"
let g:go_build_flags = '-tags="integration integration_db integration_rmq fullcycle integration_testnet integration_testnet_skip"'

let g:go_term_mode='split'

let g:lua_syntax_someoption = 1

" Google services
let g:translator_target_lang='en'
let g:translator_history_enable=v:true
let g:translator_window_type='popup' 
" else 'preview'

" timemanagement
let g:tt_use_defaults = 1


"coc config
set updatetime=300
set signcolumn=yes

let g:coc_config_home = "./dev/vim"
let g:coc_global_extensions = [ 
        \ 'coc-tslint-plugin',
        \ 'coc-tsserver', 
        \ 'coc-css', 
        \ 'coc-html',
        \ 'coc-json',
        \ 'coc-prettier',
        \ ]  " list of CoC extensions needed

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

Plug 'junegunn/goyo.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'christoomey/vim-tmux-navigator'
Plug 'j-morano/buffer_manager.nvim'
Plug 'chentoast/marks.nvim'
Plug 'tbastos/vim-lua'
Plug 'jsfaint/gen_tags.vim'

" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'preservim/nerdtree' |
           \ Plug 'Xuyuanp/nerdtree-git-plugin' |
           \ Plug 'ryanoasis/vim-devicons'

Plug 'nvim-tree/nvim-tree.lua'

" tabs
" Plug 'jistr/vim-nerdtree-tabs'
Plug 'gcmt/taboo.vim'
Plug 'godlygeek/tabular'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" status line
" Plug 'itchyny/lightline.vim'

" general coding plugins
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'andrewferrier/wrapping.nvim'
Plug 'tpope/vim-surround'
Plug 'neovim/nvim-lspconfig'
Plug 'SirVer/ultisnips'
" Plug 'mortonfox/nerdtree-clip'

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'


" Go 
Plug 'fatih/vim-go'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'hexdigest/gounit-vim'

" JS
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

" Python
Plug 'yaegassy/coc-pylsp', {'do': 'yarn install --frozen-lockfile'}

" browser integration
Plug 'tyru/open-browser.vim'

" plantuml
Plug 'aklt/plantuml-syntax'
Plug 'skanehira/preview-uml.vim'
Plug 'weirongxu/plantuml-previewer.vim' " previewer
Plug 'scrooloose/vim-slumlord' " console preview

" d2
Plug 'terrastruct/d2-vim'

" DB tools
Plug 'dinhhuy258/vim-database', {'branch': 'master', 'do': ':UpdateRemotePlugins'}

" markdown
Plug 'preservim/vim-markdown'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/vim-easy-align'
Plug 'elzr/vim-json'
Plug 'vim-pandoc/vim-pandoc-syntax'


Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
Plug 'voldikss/vim-floaterm'

" themes
Plug 'Dave-Elec/gruvbox'
Plug 'danilo-augusto/vim-afterglow'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
" Plug 'ryanoasis/vim-devicons' Icons without colours
" Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }

" misc
Plug 'nvim-lua/plenary.nvim'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" vertical block lines
Plug 'lukas-reineke/indent-blankline.nvim'

" docker
Plug 'ekalinin/Dockerfile.vim'

" icons ?
Plug 'stevearc/dressing.nvim'
Plug 'ziontee113/icon-picker.nvim'


Plug 'itchyny/calendar.vim'
Plug 'majutsushi/tagbar'

" google services
Plug 'voldikss/vim-translator'

" chatgpt
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'jackMort/ChatGPT.nvim'
Plug 'dpayne/CodeGPT.nvim'

Plug 'nvim-telescope/telescope-file-browser.nvim'

" stackoverflow
Plug 'https://github.com/mickaobrien/vim-stackoverflow'

" timemanagement
Plug 'mkropat/vim-tt'

" my plugins/forks
Plug '1llusion1st/nvim-json2gostruct'
Plug '1llusion1st/nvim-markdown-runner'
Plug '1llusion1s/nvim-jira'
Plug '1llusion1st/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown' }
Plug '1llusion1st/nvim-openai'

call plug#end()

au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

lua << EOF
require("buffer_manager").setup({
    width = 100,
    select_menu_item_commands = {
    v = {
      key = "<C-v>",
      command = "vsplit"
    },
    h = {
      key = "<C-h>",
      command = "split"
    }
  }
})
EOF

""" THEMEs

" select the color scheme
" let g:gruvbox_transparent_bg = '1'
" colorscheme gruvbox

colorscheme afterglow
let g:airline_theme='afterglow'
let g:afterglow_inherit_background=1
let g:afterglow_blackout=1

" In your init.lua or init.vim
set termguicolors
"lua << EOF
"require("bufferline").setup{}
"EOF
"
function GruvBoxLight()
  colorscheme gruvbox
  set background=light
  let g:airline_theme='gruvbox'
endfunction

function GruvBoxDark()
  colorscheme gruvbox
  set background=dark
  let g:airline_theme='gruvbox'
endfunction

call GruvBoxLight()
call GruvboxHlsShowCursor()

" NERDTree EXTENSIONS
" Nerdtree copy files between diff trees 
"

function! NERDTreeClipPathDir()
    let curFileNode = g:NERDTreeFileNode.GetSelected()
    let path = fnamemodify(curFileNode.path.str(), ':p:h')
    let @* = path
    redraw
    echomsg 'Copied to clipboard: '.path
endfunction

function! NERDTreeCopyToYankedPathHeadless()
  call NERDTreeCopyToYankedPath(1)
endfunction

function! NERDTreeCopyToYankedPathNotHeadless()
  call NERDTreeCopyToYankedPath(0)
endfunction

function! NERDTreeCopyToYankedPath(headless)
    let curFileNode = g:NERDTreeFileNode.GetSelected()
    let path = fnamemodify(curFileNode.path.str(), ':p')
    let fname = fnamemodify(curFileNode.path.str(), ':t')
    let dst = @*.'/'.fname
    echomsg 'copiing '.path.' to '.dst
    call CopyFile(path, dst, a:headless)
    echomsg path.' copied to '.@*
endfunction

function! CopyFile(src, dest, headless)
  let src_path = expand(a:src)
  let dest_path = expand(a:dest)

  if filereadable(src_path)
    new
    execute 'read ' . src_path
    execute 'write! ' . dest_path
    echo 'File copied from ' . src_path . ' to ' . dest_path
    if a:headless == 1
      q
    endif
  else
    echo 'Error: Source file not found or not readable: ' . src_path
  endif
endfunction

function NERDTreeSetupCustomActions()
  if exists("g:loaded_my_nerdtree_actions")
  else
    let g:loaded_my_nerdtree_actions = 1
    call g:NERDTreeAddMenuItem({'text': 'copy path to clip(b)oard', 'shortcut': 'b', 'callback': 'NERDTreeClipPathDir'})
    call g:NERDTreeAddMenuItem({'text': '(C)opy file to yanked path', 'shortcut': 'C', 'callback': 'NERDTreeCopyToYankedPathNotHeadless'})
    call g:NERDTreeAddMenuItem({'text': 'copy file to yanked path (H)eadless', 'shortcut': 'H', 'callback': 'NERDTreeCopyToYankedPathHeadless'})
  endif
  NERDTreeToggle
endfunction


nmap <Space>T :<C-U>call NERDTreeSetupCustomActions()<CR>

function! NERDTreeCommander()
  tabnew
  let winSize = winwidth(0)
  NERDTree
  let currNerdTreeBufN = bufnr('%')
  tabnew
  NERDTree
  :exe "normal \<c-w>\<c-w>"
  :exe "b ".currNerdTreeBufN
  :exe "vertical resize ".(winSize / 2)
  tabprev
  tabc

endfunction

" END NERDTree EXTENSIONS

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

let g:mkdp_refresh_slow = 1
function OpenMarkdownPreview (url)
    execute "silent ! brave-browser --new-window " .  a:url
endfunction
let g:mkdp_browserfunc = 'OpenMarkdownPreview'
let g:mkdp_auto_close = 0

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
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_frontmatter = 1

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger  = '<A-d>'
let g:UltiSnipsJumpBackwardTrigger = '<A-a>'

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

lua require("toggleterm").setup()
lua << EOF
require("chatgpt").setup({
  keymaps = {
          submit = "<C-s>"
  }

})
EOF

" set modifiable
"
"

lua require("telescope").load_extension "file_browser"

lua require("nvim-tree").setup()


