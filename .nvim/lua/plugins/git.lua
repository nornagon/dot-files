if not vim.g.vscode then
  return {
    'tpope/vim-fugitive',

    --'airblade/vim-gitgutter',
    'lewis6991/gitsigns.nvim',
  }
else
  return {}
end
