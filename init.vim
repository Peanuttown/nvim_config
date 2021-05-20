call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf' 
Plug 'junegunn/fzf.vim' 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'OmniSharp/omnisharp-vim'
Plug 'easymotion/vim-easymotion'
"Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'fatih/vim-go', 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'mfussenegger/nvim-dap'
call plug#end()


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

let lang_list = ["go"]
nnoremap -f :Files<CR>
nnoremap -b :Buffers<CR>

augroup tzz-coc
	au! 
	exec "autocmd FileType " . join(lang_list,",") . " inoremap <silent><expr> <c-o> coc#refresh()"
	exec "autocmd FileType " . join(lang_list,",") . " nmap <buffer> <c-]> :lua tzz_coc_jump_def()<CR>"
	exec "autocmd FileType " . join(lang_list,",") . " nmap <buffer> <c-n> <Plug>(coc-diagnostic-next)" 
augroup end

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
nnoremap -w :up<CR>
inoremap <c-b> <left>
inoremap -g <ESC>
inoremap <cr> <Cmd> call TzzEnter()<Cr>
inoremap <c-e> <ESC><s-a>
inoremap { {}<left>
inoremap ( ()<left>
inoremap ) <Cmd> call  TzzFeedLeftParenthese()<CR>
inoremap <c-l> <ESC>o



lua << EOF
	local utils = require("utils")
	local vimfn = vim.fn
	function tzzJumpToDef(doJump)
	    if utils.buffer_modified() and (vimfn.len(vimfn.win_findbuf(vimfn.bufnr('%'))) < 2 ) then
		print("split")
		vim.cmd("normal -vs")
	    end
	    -- vim.lsp.buf.definition()
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
EOF


lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"go"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF

let g:OmniSharp_server_path = 'D:\tools\omnisharp\OmniSharp.exe'

"colorscheme gruvbox
set background=dark
colorscheme gruvbox-material
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


