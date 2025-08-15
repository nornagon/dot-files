vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false

require("config.lazy")

-- General settings
vim.o.visualbell = true -- omg stop beeping at me
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 79
vim.opt.autoindent = true
vim.opt.smarttab = true

-- keep 4 lines between the cursor and the edge of the screen where possible
vim.opt.scrolloff = 4

-- copy indentation style from the previous line. this means if i do:
-- if (blah) {<CR>
-- <TAB>int x = 0,<CR>
-- <TAB>____y = 3,<CR>
--
-- i will get
-- <TAB>____(cursor)
-- instead of
-- <TAB><TAB><TAB>(cursor)
--
-- good for using tabs as they were intended (i.e, to indent) and then using
-- spaces for formatting.
vim.opt.copyindent = true

-- highlight the line the cursor is on. usually done with an underline, but it
-- is configurable by color scheme.
vim.opt.cursorline = true

-- when i :set list, show tabs with unicode arrows instead of as ^I
vim.opt.listchars:append("tab:►─")

-- wrap on word breaks, not between characters
-- there's a space at the end of that line, after the \. that's important.
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "↪ "

-- for completing file names, etc. complete the longest match. if i press tab
-- again, show me a list. if i press tab again, start cycling through the
-- options.
vim.opt.wildmode = "longest,list,full"

-- helps for function completion.
vim.opt.path = { ".", "/usr/include", "/usr/include/*", "" }

-- Useful for electron
vim.opt.path:append("..")

-- Search should only be case-sensitive if a non-lowercase letter is typed.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- for completion in insert mode (^X^P etc).
vim.opt.completeopt = { "longest", "menuone" }

-- show file position in bottom-right corner
vim.opt.ruler = true
-- don't show a 1-line status bar at the bottom of the window
vim.opt.laststatus = 0

-- let % work on <> pairs
vim.opt.matchpairs:append("<:>")

-- do sane things with insane line endings, hopefully.
vim.opt.fileformats = { "unix", "mac", "dos" }

-- the one true shell
vim.opt.shell = "/bin/zsh"

-- r=insert comment leader when <Return> in insert mode
-- j=remove comment leader when joining lines
-- This is in an autocmd because it seems to be often overridden
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:append("rj")
	end,
})

if not vim.g.vscode then
	-- when you open a file you were just editing, vim should remember which line
	-- you were on and put you back there.
	--set viminfo='50,\"100,:40,n~/.viminfo
	vim.api.nvim_create_autocmd("BufReadPost", {
		pattern = "*",
		callback = function()
			local last_pos = vim.fn.line([['"]])
			if last_pos > 1 and last_pos <= vim.fn.line("$") and vim.bo.filetype ~= "commit" then
				vim.cmd('normal! g`"')
			end
		end,
	})
end

-- let the mouse work in console mode. I generally just use it for the scroll
-- wheel.
-- if &term == "screen"
--   set ttymouse=xterm2
-- endif
if vim.fn.has("mouse") == 1 and not vim.fn.has("gui_running") then
	vim.opt.mouse = "nvir"
end

-- put swap files in ~/.vim-swp instead of in the directory of the file.
-- double / at the end means to uniquify the swap file names by using the full
-- path and replacing / with %
--silent !mkdir -p ~/.vim-swp
--set directory=~/.vim-swp//

-- i hold shift down too long when i hit :w...
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Q", "q", {})

--noremap <S-m> :w<CR>:!mvim %<CR>:q<CR>

-- f1 does not need to do :h for me, thanks. especially since it's so close to ESC
vim.keymap.set({ "n", "i" }, "<F1>", "<nop>", { noremap = true })
vim.keymap.set("", "<S-CR>", "<nop>", { noremap = true })
vim.keymap.set("", "H", "<nop>", { noremap = true })
vim.keymap.set("", "L", "<nop>", { noremap = true })

-- C-h is a more ergonomic way to type 'esc'
vim.keymap.set("i", "<C-h>", "<Esc>", { noremap = true })
vim.keymap.set("v", "<C-h>", "<Esc>", { noremap = true })
vim.keymap.set("o", "<C-h>", "<Esc>", { noremap = true })
vim.keymap.set("n", "<C-h>", "<Esc>", { noremap = true })

-- Esc in terminal mode should go back to normal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

--[[
if not vim.g.vscode then
  -- CleverTab - if at start of line insert spaces; else complete word
  vim.keymap.set('i', '<Tab>', function()
    local col = vim.fn.col('.')
    local line = vim.fn.getline('.')
    local strpart = line:sub(1, col - 1)
    if strpart:match('^%s*$') then
      return '\t'
    else
      return vim.api.nvim_replace_termcodes('<C-N>', true, true, true)
    end
  end, { expr = true })
end
]]

-- for C files, expand #i<SPACE> to #include<SPACE>, and similarly for #define.
-- set foldmethod=marker because C sucks at modularisation, and {{{/}}} makes
-- code much easier to move around. 'zt' -> 'z(this)', closes all folds but the
-- one under the cursor.
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		vim.cmd("iabbrev #i #include")
		vim.cmd("iabbrev #d #define")
		vim.opt_local.foldmethod = "marker"
	end,
})

-- Don't wrap JSON at 80 chars.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "json",
	command = "setlocal textwidth=0",
})

-- Let's all pretend
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.glsl", "*.vert", "*.frag" },
	command = "setfiletype c",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.scss", "*.css" },
	callback = function()
		vim.opt_local.iskeyword:append("-")
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.gn", "*.gni" },
	command = "setfiletype conf",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.gyp", "*.gypi" },
	command = "setfiletype python",
})

if not vim.fn.has("gui_running") then
	vim.opt.background = "dark"
end

-- dvorak bindings for htns -> navigation. ... wish i could work out a way to
-- hook this into OS X to work out the currently active keymap.
--
-- k becomes 'find next' (in place of 'n')
-- j becomes 'until before next occurrance of' (in place of t)

vim.keymap.set("", "t", "j", { noremap = true })
vim.keymap.set("", "j", "t", { noremap = true })
vim.keymap.set("", "n", "k", { noremap = true })
vim.keymap.set("", "k", "n", { noremap = true })
vim.keymap.set("", "s", "l", { noremap = true })
vim.keymap.set("", "l", "s", { noremap = true })
vim.keymap.set("", "<S-t>", "12j", { noremap = true })
vim.keymap.set("", "<S-n>", "12k", { noremap = true })
vim.keymap.set("", "K", "N", { noremap = true })

-- ctrl-(up/down) nav keys change tabs
vim.keymap.set("", "<C-t>", "<C-PageDown>", { noremap = true })
vim.keymap.set("", "<C-n>", "<C-PageUp>", { noremap = true })
vim.keymap.set("i", "<C-t>", "<C-PageDown>", { noremap = true })
vim.keymap.set("i", "<C-n>", "<C-PageUp>", { noremap = true })

-- editor
vim.opt.hlsearch = true
vim.keymap.set("n", "z", "zz")
--nmap * *K
vim.keymap.set("n", "\\", ":noh<CR>")

-- Alt-O opens .h file if pressed in .cpp file and vice-versa.
local function RelatedFiles()
	local files = vim.fn.globpath(vim.fn.expand("%:h"), vim.fn.expand("%:t:r") .. ".*")
	files = vim.fn.split(files)
	files = vim.tbl_filter(function(val)
		return not vim.fn.bufloaded(val) or vim.fn.getbufinfo(val)[1].hidden
	end, files)
	return files
end

local function OpenRelatedFile()
	local files = RelatedFiles()
	if #files > 0 then
		if files[1]:match("%.h$") then
			vim.cmd("leftabove vsplit " .. files[1])
		else
			vim.cmd("rightbelow vsplit " .. files[1])
		end
	end
end

--nmap o :call OpenRelatedFile()<CR>
vim.keymap.set("n", "<M-o>", OpenRelatedFile, { noremap = true })
vim.keymap.set("n", "ø", OpenRelatedFile, { noremap = true })

vim.env.BAT_THEME = "zenburn"
vim.env.FZF_DEFAULT_COMMAND = "rg -F --files --color never"
--vim.keymap.set('n', '<C-P>', ':FZF<CR>', { noremap = true })

-- let g:ctrlp_map = '<c-p>'
-- let g:ctrlp_cmd = 'CtrlP'
-- let g:ctrlp_max_depth = 40
-- let g:ctrlp_max_files = 0
-- "let g:ctrlp_match_func = {'match' : 'matcher#cmatch'}
-- "let g:ctrlp_clear_cache_on_exit = 0
-- let g:ctrlp_use_caching = 0
-- " Requires ripgrep
-- let g:ctrlp_user_command = '/opt/homebrew/bin/rg -F --files --color never %s'

-- Don't show these in CtrlP
vim.opt.wildignore:append({ "*/out/*", "*/gen/*", "*.so", "*.swp", "*.zip", "*/tmp/*", "*.pyc", "*.class" })
vim.opt.wildignore:append({ "*/scala-2.10/cache/*", "*.class", "*/$global/*", "*/reports/*" })
vim.opt.wildignore:append({ "*/_site/*" })

vim.g.fzf_vim = {}
--let g:fzf_vim.preview_window = []

-- + greps for the token under the cursor
vim.opt.grepprg = "rg --vimgrep --no-heading"
vim.opt.grepformat = { "%f:%l:%c:%m", "%f:%l:%m" }

if vim.g.vscode then
	vim.keymap.set(
		"n",
		"+",
		"<Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>",
		{ noremap = true }
	)
else
	--[[
  vim.keymap.set('n', '+', function()
    local word = vim.fn.expand('<cword>')
    local escaped_word = vim.fn['fzf#shellescape']('\\b' .. word .. '\\b')
    local command = 'rg --column --line-number --no-heading --color=always --smart-case -- ' .. escaped_word
    vim.fn['fzf#vim#grep'](command, vim.fn['fzf#vim#with_preview'](), 0)
  end, { noremap = true, silent = true })
  ]]
end

vim.opt.switchbuf:append({ "usetab", "newtab" })

vim.g.syntastic_coffee_coffeelint_args = "--csv --file ~/.coffeelint.json"
vim.g.syntastic_error_symbol = "✗"
vim.g.syntastic_warning_symbol = "⚠"
vim.g.syntastic_style_error_symbol = "✦"

vim.g.jsx_ext_required = 0

vim.g.javascript_plugin_flow = 1

vim.keymap.set("n", "<S-h>", ":SidewaysLeft<CR>", { noremap = true })
vim.keymap.set("n", "<S-s>", ":SidewaysRight<CR>", { noremap = true })

vim.cmd("colorscheme desert")

vim.opt.guifont = "JetBrains Mono:h14"
if vim.fn.has("gui_vimr") == 1 then
	-- set guioptions-=m    " No menus
	-- set guioptions-=T    " No toolbar
	-- set guioptions-=r    " No scrollbars
	--
	-- set guicursor=a:blinkon0 " No cursor blinky
	--
	--  Fonts and other GUI settings
	-- set guifont=Menlo:h12
	-- set transparency=10

	--  Switch tabs with Cmd-Alt-<Arrows>, like Chrome
	vim.keymap.set("n", "<D-M-Right>", "gt")
	vim.keymap.set("n", "<D-M-Left>", "gT")
	vim.cmd("hi LineNr guifg=#a0a0a0 guibg=NONE")
end

if vim.g.neovide then
	vim.g.neovide_remember_window_size = true
end

--[[
if not vim.g.vscode then
	require("avante_lib").load()
end
]]

-------------------------------------------------------------------------------
-- Binary editing stuff

-- 128GO to jump 128 bytes
-- 128Go to jump -128 bytes
local function JumpToByte(byte_nr)
	local crt_byte = vim.fn.line2byte(vim.fn.line(".")) + vim.fn.col(".") - 1
	local dst_byte = crt_byte + byte_nr
	vim.cmd("normal " .. dst_byte .. "go")
end

vim.keymap.set("n", "GO", function()
	JumpToByte(vim.v.count)
end, { noremap = true, silent = true })

vim.keymap.set("n", "Go", function()
	JumpToByte(-vim.v.count)
end, { noremap = true, silent = true })

-- vim -b : edit binary using xxd format
vim.api.nvim_create_augroup("Binary", {})
vim.api.nvim_create_autocmd("BufReadPre", {
	group = "Binary",
	pattern = "*.bin",
	callback = function()
		vim.opt_local.binary = true
	end,
})
vim.api.nvim_create_autocmd("BufReadPost", {
	group = "Binary",
	pattern = "*.bin",
	callback = function()
		if vim.opt_local.binary:get() then
			vim.cmd("%!xxd -p -c 64")
			vim.opt_local.filetype = "xxd"
		end
	end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = "Binary",
	pattern = "*.bin",
	callback = function()
		if vim.opt_local.binary:get() then
			vim.cmd("%!xxd -p -c 64 -r")
		end
	end,
})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = "Binary",
	pattern = "*.bin",
	callback = function()
		if vim.opt_local.binary:get() then
			vim.cmd("%!xxd -p -c 64")
			vim.opt_local.modified = false
		end
	end,
})
