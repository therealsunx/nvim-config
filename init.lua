--  remaps
print("Welcome back !")
vim.g.mapleader = " "

vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 20
vim.g.netrw_hide = 0
vim.g.netrw_banner = 0

vim.opt.nu = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.cmd [[packadd packer.nvim]]

-- -------- Esc exits from unmodifiable buffers
function CloseFloatingWindow()
    local buf = vim.api.nvim_get_current_buf()
    local is_modifiable = vim.api.nvim_buf_get_option(buf, 'modifiable')

    if not is_modifiable then
        vim.cmd('silent! bd')
    end
end

vim.cmd([[
augroup CloseNonModifiableBuffers
  autocmd!
  autocmd BufEnter * if !&modifiable || &buftype == 'nofile' | silent! nnoremap <buffer> <Esc> :lua CloseFloatingWindow()<CR> | endif
augroup END
]])
-- --------------------------------------------

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('ThePrimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'neovim/nvim-lspconfig' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }
    use "ellisonleao/gruvbox.nvim"
    use "christoomey/vim-tmux-navigator"
    use "akinsho/flutter-tools.nvim"
end)


require("gruvbox").setup({
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "",  -- can be "hard", "soft" or empty string
    palette_overrides = {
        dark0 = "#242010",
        dark1 = "#242020",
        bright_red = "#e55c1b",
        bright_green = "#aab416",
        bright_yellow = "#fabd2f",
        light1 = "#dbcbb2",
    },
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})

--vim.cmd("colorscheme rose-pine-moon")
vim.cmd("colorscheme gruvbox")

vim.api.nvim_set_hl(0, "Normal", { bg = "#161410" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "c_sharp", "lua", "javascript", "typescript", "python", "css", "hlsl", "vim" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local builtin = require('telescope.builtin')
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver',
        'pyright',
        'omnisharp',
    },
    handlers = { lsp_zero.default_setup }
})

vim.api.nvim_create_user_command('E', function(opts)
    local cd = vim.fn.expand('%:p:h')
    vim.cmd('e ' .. vim.fn.fnameescape(cd .. '/' .. opts.args))
end, { nargs = 1 })

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", '<leader>a', mark.add_file)
vim.keymap.set("n", '<leader>e', ui.toggle_quick_menu)

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>sg', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
--vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
--vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })

vim.keymap.set("n", '<leader>u', vim.cmd.UndotreeToggle)
vim.keymap.set("n", '<leader>gs', vim.cmd.Git)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>fr", function() vim.lsp.buf.format() end)
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end)

vim.keymap.set("n", '<leader>s', ":%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>")
vim.keymap.set("n", '<leader>vs', vim.cmd.vsplit)
vim.keymap.set("n", '<leader>hs', vim.cmd.split)
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-j>", "<C-w>j")

vim.keymap.set("n", ".", function() vim.cmd("10winc >") end)
vim.keymap.set("n", ",", function() vim.cmd("10winc <") end)

vim.keymap.set("n", "<C-]>", "<C-w>5-")
vim.keymap.set("n", "<C-[>", "<C-w>5+")

vim.keymap.set("n", "<BS>", "<C-6>")

vim.keymap.set("n", "<leader>tr", function() vim.cmd(":term") end)
vim.keymap.set("n", "<leader>vt", function()
    vim.cmd(":vsplit")
    vim.cmd(":term") 
end)
vim.keymap.set("n", "<leader>ht", function()
    vim.cmd(":split")
    vim.cmd(":term")
end)

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- vim.keymap.set("v", "<C-k>", ":s/\\(.*\\)/\\/\\/\\1<Enter>")
-- vim.keymap.set("n", "<C-k>", "I// <Esc>j")
