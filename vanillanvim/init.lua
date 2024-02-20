vim.opt.number = true
vim.opt.relativenumber = true

-- Mappings
vim.g.mapleader = " "
vim.keymap.set('i', "jk", "<esc>")
vim.keymap.set('n', "<leader>q", "<cmd>confirm q<cr>")
vim.keymap.set('n', "<leader>w", "<cmd>w<cr>")

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true

vim.opt.hidden = true
vim.opt.laststatus = 1
vim.opt.display = lastline

vim.opt.showmode = true
vim.opt.showcmd = true

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true

vim.opt.ttyfast = true
vim.opt.lazyredraw = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.cursorline = true
vim.opt.wrapscan = true
vim.opt.report = 0
vim.opt.synmaxcol = 200

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-treesitter/nvim-treesitter" },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
      dependencies = { 'nvim-lua/plenary.nvim' },
  }
}, opts)

vim.cmd.colorscheme "catppuccin-frappe"
