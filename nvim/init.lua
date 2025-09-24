-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"

require("lazy").setup({
	spec = {
		{
			'kepano/flexoki-neovim',
			name = 'flexoki',
			init = function()
			end
		},
		{
			"vague2k/vague.nvim",
			init = function()
				vim.cmd.colorscheme "vague"
			end
		},
		{
			"nvim-mini/mini.pick",
			init = function()
				require('mini.pick').setup()
				vim.keymap.set('n', '<c-p>', function() MiniPick.builtin.files({ tool = "git" }) end)
				vim.keymap.set('n', '<c-h>', function() MiniPick.builtin.help() end)
			end
		},
		{
			"neovim/nvim-lspconfig",
			init = function()
				-- LUA LS
				local lspconfig = require("lspconfig")
				lspconfig.gopls.setup({})

				vim.lsp.enable({ 'luals', 'tinymist' })
				vim.lsp.config['luals'] = {
					cmd = { 'lua-language-server' },
					filetypes = { 'lua' },
					root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
					settings = {
						Lua = {
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
							},
							runtime = {
								version = 'LuaJIT',
							}
						}
					}
				}


				vim.api.nvim_create_autocmd('LspAttach', {
					callback = function(ev)
						local client = vim.lsp.get_client_by_id(ev.data.client_id)
						if client:supports_method('textDocument/complettion') then
							vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
						end
					end,
				})
				vim.cmd("set completeopt+=noselect")

				vim.keymap.set('i', '<c-space>', function()
					vim.lsp.completion.get()
				end)
			end
		},
		{
			'stevearc/oil.nvim',
			---@module 'oil'
			---@type oil.SetupOpts
			opts = {},
			-- Optional dependencies
			dependencies = { { "echasnovski/mini.icons", opts = {} } },
			-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
			-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
			lazy = false,
			init = function()
				require 'oil'.setup()
				vim.keymap.set('n', '<leader>e', ':Oil<CR>')
			end
		},
		{
			'windwp/nvim-autopairs',
			event = "InsertEnter",
			config = true
			-- use opts = {} for passing setup options
			-- this is equivalent to setup({}) function
		},
		{
			'mason-org/mason.nvim',
			init = function()
				require "mason".setup()
			end
		},
		{ "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate" },
		{
			"catgoose/nvim-colorizer.lua",
			event = "BufReadPre",
			opts = { -- set to setup table
			},
		}
	},
	install = { colorscheme = { "vague" } },
	checker = { enabled = false },
})

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>Q', ':wq<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
vim.keymap.set('v', '<leader>y', '"+y<CR>')
