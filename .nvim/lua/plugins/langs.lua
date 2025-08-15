-- Language support
-- Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
-- Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
-- Plug 'scrooloose/syntastic'
-- Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

-- Plug 'jazzcore/ctrlp-cmatcher', { 'do': './install.sh' }
-- Plug 'ctrlpvim/ctrlp.vim'
if not vim.g.vscode then
  return {
    'tpope/vim-sleuth',
    --{ 'junegunn/fzf', { 'do': { -> fzf#install() } }
    --'junegunn/fzf.vim',
    --'ibhagwan/fzf-lua',
    --[[
    'scrooloose/nerdtree',
    'github/copilot.vim',
    'pangloss/vim-javascript',
    'flowtype/vim-flow',
    'leafgarland/typescript-vim', -- typescript syntax
    --Plug 'Quramy/tsuquyomi'           " typescript fanciness
    --Plug 'Shougo/vimproc.vim'         " required by tsuquyomi
    'mxw/vim-jsx',
    'kchmck/vim-coffee-script',
    'groenewege/vim-less', -- lesscss
    'elzr/vim-json',
    'Shirk/vim-gas',
    'derekwyatt/vim-scala',
    'hail2u/vim-css3-syntax',
    'cakebaker/scss-syntax.vim',
    'ziglang/zig.vim',
    'LnL7/vim-nix',
    'stephpy/vim-yaml',
    ]]
    { -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      main = 'nvim-treesitter.configs', -- Sets main module to use for opts
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      opts = {
        ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = {
          enable = true,
          -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
          --  If you are experiencing weird indenting issues, add the language to
          --  the list of additional_vim_regex_highlighting and disabled languages for indent.
          additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = { enable = true, disable = { 'ruby' } },
      },
      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    },
  }
else
  return {}
end
