call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'OmniSharp/omnisharp-vim'
"Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
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
augroup end

augroup tzz-omnisharp
	au! 
	" exec "autocmd FileType " . join(lang_list,",") . " inoremap <silent><expr> <c-o> coc#refresh()"
	exec "autocmd FileType " . "cs" . " nmap <buffer> <c-]> :lua tzz_omnisharp_def()<CR>"
augroup end

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

let g:OmniSharp_server_path = 'D:\tools\omnisharp\OmniSharp.exe'

"colorscheme gruvbox
set background=dark
colorscheme gruvbox-material

