-- This config was based upon the following resources:
-- https://oroques.dev/notes/neovim-init/
-- https://crispgm.com/page/neovim-is-overpowering.html

-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------- PLUGINS -------------------------------
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Colors - base16 color schemes
  use 'RRethy/nvim-base16'

  -- autocompletion
  use 'hrsh7th/nvim-compe'

  -- tree sitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig'

  -- telescope for finding things
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  -- Essential plugins
  use 'scrooloose/nerdTree'
  use 'itchyny/lightline.vim'

  -- Tpope things
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-endwise'

  use 'preservim/nerdcommenter'

  -- highlight whitesace
  use 'ntpeters/vim-better-whitespace'

  use {'prettier/vim-prettier', run = 'yarn install'}

  -- better markdown support
  use 'plasticboy/vim-markdown'

end)


-------------------- OPTIONS -------------------------------
cmd 'colorscheme base16-default-dark'            -- Put your favorite colorscheme here
opt.completeopt = "menuone,noselect"
opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
opt.backup = false
opt.swapfile = false
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.number = true                   -- Show line numbers
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = 2                  -- Size of an indent
opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = 2                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap

-------------------- Completion ------------------------------

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}


-------------------- MAPPINGS ------------------------------

vim.g.mapleader = ","

map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('', '<C-p>', "<cmd>Telescope find_files<cr>")
-- map('', '<cr>', ':nohlsearch<cr>')

vim.api.nvim_set_keymap('', '<leader>n', "<cmd>NERDTreeToggle<cr>", {noremap = true, silent = false})
vim.api.nvim_set_keymap('', '<leader>w', "<cmd>wq!<cr>", {noremap = true, silent = false})

-------------------- TREE-SITTER ---------------------------
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}

-------------------- Prettier ------------------------------
vim.cmd("let g:prettier#autoformat_config_present = 1")
vim.cmd("let g:prettier#autoformat_require_pragma = 0")

-------------------- Markdown options ------------------------
vim.cmd("let g:vim_markdown_folding_disabled = 1")

-------------------- Whitespace ------------------------------
vim.cmd("let g:strip_whitespace_on_save=1")

-------------------- Telescope ---------------------------
require('telescope').setup{
  defaults = {
    file_sorter = require'telescope.sorters'.get_fzy_sorter
  }
}

-------------------- LSP -----------------------------------
local lsp = require 'lspconfig'

-- For ccls we use the default settings
lsp.ccls.setup {}
-- root_dir is where the LSP server will start: here at the project root otherwise in current folder
--

lsp.diagnosticls.setup {
  filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact", "css"},
  init_options = {
    filetypes = {
      javascript = "eslint",
      typescript = "eslint",
      javascriptreact = "eslint",
      typescriptreact = "eslint"
    },
    linters = {
      eslint = {
        sourceName = "eslint",
        command = "./node_modules/.bin/eslint",
        rootPatterns = {
          ".eslitrc.js",
          "package.json"
        },
        debounce = 100,
        args = {
          "--cache",
          "--stdin",
          "--stdin-filename",
          "%filepath",
          "--format",
          "json"
        },
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity"
        },
        securities = {
          [2] = "error",
          [1] = "warning"
        }
      }
    }
  }
}

-- Set up language-specific stuff
require'lspconfig'.gopls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.solargraph.setup{}
