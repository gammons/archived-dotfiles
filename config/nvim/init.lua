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
  use 'glepnir/lspsaga.nvim'

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
  use 'tpope/vim-rails'

  -- For commenting out code
  use 'preservim/nerdcommenter'

  -- highlight whitesace
  use 'ntpeters/vim-better-whitespace'

  use {'prettier/vim-prettier', run = 'yarn install'}

  -- testing made easy
  use 'janko-m/vim-test'
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
opt.wrap = true                    -- Disable line wrap

vim.cmd("let NERDTreeShowHidden=1") -- show hidden files in NERD

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
  documentation = false;

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

cmd("autocmd FileType markdown call compe#setup({'enabled': v:false})")
cmd("autocmd FileType gitcommit call compe#setup({'enabled': v:false})")
cmd("command! Wq wq")

-------------------- MAPPINGS ------------------------------

vim.g.mapleader = ","

map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('', '<C-p>', "<cmd>Telescope find_files<cr>")
map('', '<cr>', ':nohlsearch<cr>')
map('', '<C-_>', ":call nerdcommenter#Comment('x','toggle')<cr>")

map('', '<Leader>e', ":e <C-R>=expand(\"%:p:h\") . '/'<CR>")
map('', '<Leader>s', ":split <C-R>=expand(\"%:p:h\") . '/'<CR>")

-- testing
map('', '<Leader>r', ":TestFile<CR>")
map('', '<Leader>a', ":TestSuite<CR>")
map('', '<Leader>t', ":TestSuite<CR>")

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

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true, -- show that there is a problem
    virtual_text = false, -- I can't deal with virtual text
  }
)

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<Leader>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end
end


local nvim_lsp = require 'lspconfig'
local servers = { "gopls", "tsserver", "solargraph" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local saga = require 'lspsaga'
saga.init_lsp_saga()
