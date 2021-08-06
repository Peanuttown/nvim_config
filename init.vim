call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf' 
Plug 'junegunn/fzf.vim' 
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'OmniSharp/omnisharp-vim'
Plug 'easymotion/vim-easymotion'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'fatih/vim-go', 
Plug 'altercation/vim-colors-solarized'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'vimwiki/vimwiki'
Plug 'NLKNguyen/papercolor-theme'
"Plug 'mfussenegger/nvim-dap'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
"Plug 'ryanoasis/vim-devicons'
"Plug 'folke/lsp-colors.nvim'
Plug 'kyazdani42/nvim-web-devicons'
"Plug 'romgrk/barbar.nvim'
Plug 'folke/trouble.nvim',{ 'do': ':lua print(1)' }
Plug 'ray-x/lsp_signature.nvim'
Plug 'overcache/NeoSolarized'
" <
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" >
call plug#end()


lua require("tz_lsp")

lua << EOF
  require("trouble").setup {}
EOF

let g:solarized_termcolors=256

" < set -es to edit VIMRC
lua << EOF
	local first_runtime_path_index = string.find(vim.o["runtimepath"],",") - 1
	local first_runtime_path =  string.sub(vim.o["runtimepath"],0,first_runtime_path_index)
	vim.cmd(string.format("nnoremap -e :e %s/init.vim <CR>",first_runtime_path))
	local init_vim_filepath = string.format("%s/init.vim",first_runtime_path)
	vim.cmd(string.format("nnoremap -es :e %s/init.vim <CR>",first_runtime_path))
	vim.cmd(string.format("nnoremap -ss :source %s/init.vim <CR>",first_runtime_path))
	vim.cmd(string.format("let g:init_vim='%s'",init_vim_filepath))
EOF
"

let lang_list = ["go,dart"]
"nnoremap -f :Files<CR>
"nnoremap -b :Buffers<CR>

"augroup tzz-coc
"	au! 
"	exec "autocmd FileType " . join(lang_list,",") . " inoremap <silent><expr> <c-o> coc#refresh()"
"	exec "autocmd FileType " . join(lang_list,",") . " nmap <buffer> <c-]> :lua tzz_coc_jump_def()<CR>"
"	exec "autocmd FileType " . join(lang_list,",") . " nmap <buffer> <c-n> <Plug>(coc-diagnostic-next)" 
"augroup end
"

augroup tzz-omnisharp
	au! 
	" exec "autocmd FileType " . join(lang_list,",") . " inoremap <silent><expr> <c-o> coc#refresh()"
	exec "autocmd FileType " . "cs" . " nmap <buffer> <c-]> :lua tzz_omnisharp_def()<CR>"
augroup end

"augroup tzz-dap
"	au! 
"	exec "lua require('dap/go')"
"augroup end
nnoremap -vs :vs<CR><c-w>l
nnoremap -tt :tabnew<CR>:terminal<CR>
nnoremap -tc :terminal<CR>
nnoremap -tp :lua require("utils").term_in_cur_file_dir()<CR>
nnoremap -ts :vs<CR><c-w>l:terminal<CR>
nnoremap <s-u> :e#<CR>
nnoremap -q :q<CR>
nnoremap -nn :NERDTree<CR>
nnoremap -nc :NERDTreeClose<CR>
nnoremap -nf :NERDTreeFind<CR>
nnoremap <s-e> :NERDTreeToggle<CR>
tnoremap <c-j> <c-\><c-n>
nmap -g <Plug>(easymotion-s2)
nmap -mt <Plug>BookmarkToggle
nmap -ma  <Plug>BookmarkAnnotate
nmap -ms  <Plug>BookmarkShowAll
nnoremap <silent> \dc :lua require'dap'.continue()<CR>
nnoremap <silent> \dn :lua require'dap'.step_over()<CR>
nnoremap <silent> \di :lua require'dap'.step_into()<CR>
nnoremap <silent> \do :lua require'dap'.step_out()<CR>
nnoremap <silent> \db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> \dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> -c :Commands<CR>
nnoremap -f <cmd>Telescope find_files<cr>
inoremap <M-p> <cmd>Telescope find_files<cr>
inoremap <M-P> <cmd>Telescope buffers<cr>
nnoremap -b <cmd>Telescope buffers<cr>
inoremap <C-s> <Esc>:wa<CR>
inoremap <c-b> <left>
inoremap -g <ESC>
inoremap <cr> <Cmd> call TzzEnter()<Cr>
inoremap <c-e> <ESC><s-a>
inoremap { {}<left>
inoremap ( ()<left>
inoremap ) <Cmd> call  TzzFeedLeftParenthese()<CR>
inoremap -w <ESC>:wa<CR>
nnoremap -w :wa<CR>
inoremap jk <ESC>
inoremap <c-a> <ESC>0a
inoremap <c-n> <Down>
inoremap <c-p> <Up>
inoremap <c-f> <Right>
inoremap <M-f> <ESC>ea
inoremap <c-j> <ESC>o
inoremap <c-l> <ESC>zza
inoremap <c-k> <ESC><Right>Da
inoremap <c-> <ESC>u
inoremap <M-b> <ESC>bi
inoremap <M-h> <ESC>dawa
inoremap { {}<Left>
inoremap <c-e> <ESC><s-a>
inoremap <c-h> <c-w>
inoremap <M-}> <Esc>}i
inoremap <M-{> <Esc>{i
inoremap <M-<> <Esc>ggi
inoremap <M->> <Esc>Gi
inoremap <M-m> <Esc>mna
inoremap <M-P> <Esc>%a
"map <c-p> to manually trigger completion
imap <silent> <c-o> <Plug>(completion_trigger)




lua << EOF
	local utils = require("utils")
	local vimfn = vim.fn
	function tzzJumpToDef(doJump,doBeforeJump)
      print("tzzJumpToDef")
	    if utils.buffer_modified() and (vimfn.len(vimfn.win_findbuf(vimfn.bufnr('%'))) < 2 ) then
		vim.cmd("normal -vs<CR>")
	    end
	    -- vim.lsp.buf.definition()
      if doBeforeJump then
        doBeforeJump()
      end
	    doJump()
	end

	function tzz_omnisharp_jump_def_wrapper()
		vim.cmd("OmniSharpGotoDefinition")
	end

	function tzz_omnisharp_def()
		tzzJumpToDef(tzz_omnisharp_jump_def_wrapper)
	end

	function tzz_coc_jump_def_wrapper()
		vim.cmd("call CocActionAsync('jumpDefinition')")
	end

	function tzz_coc_jump_def()
		tzzJumpToDef(tzz_coc_jump_def_wrapper)
	end

  function tzz_lsp_jump_def()
		tzzJumpToDef(
      vim.lsp.buf.definition
    )
    return
		tzzJumpToDef(
      vim.lsp.buf.definition,
      function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<cr>',true,false,true),'m',true)
      end
    )
  end
EOF


"lua <<EOF
"require'nvim-treesitter.configs'.setup {
"  ensure_installed = {"go"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
"  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
"  highlight = {
"    enable = true,              -- false will disable the whole extension
"    -- disable = { "c", "rust" },  -- list of language that will be disabled
"  },
"}
"EOF

"let g:OmniSharp_server_path = 'D:\tools\omnisharp\OmniSharp.exe'
"

-
set background=light
colorscheme PaperColor

"hi Normal ctermbg=NONE guibg=NONE

ab :flower: 🌸
ab :tada: 🎉
ab :cross: ❌
ab :check: ✅
ab :warning:⚠️
ab :bug: 🐛
ab :devil: 😈
ab :ch: တ
ab :yy: ဈ
ab :loading: ⌛

set ignorecase
set autoindent
set nu
set matchpairs+=^:$,တ:ဈ,<:>
set expandtab
set smartcase
set tabstop=2
set shiftwidth=2
let g:bookmark_no_default_key_mappings = 1
let g:go_gopls_enabled = 0
let g:neovide_transparency=0.8
let g:neovide_cursor_vfx_mode = "railgun"
set maxmempattern=100000000
" set guifont=Hack:h20
set guifont=Hack_Nerd_Font:h20
set encoding=utf-8
set fileencoding=utf-8


let g:completion_enable_auto_popup = 0
let g:completion_confirm_key = ""



