return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',
			{
				'pmizio/typescript-tools.nvim',
				dependencies = 'nvim-lua/plenary.nvim',
				config = true,
			},
			{
				'j-hui/fidget.nvim',
				opts = { notification = { window = { border = 'rounded' } } },
			},
			{ 'folke/neodev.nvim', config = true },
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			capabilities = vim.tbl_deep_extend(
				'force',
				capabilities,
				require('cmp_nvim_lsp').default_capabilities()
			)

			local servers = {
				-- markdown_oxide = {
				-- 	capabilities = capabilities, -- ensure that capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
				-- 	root_dir = require('lspconfig').util.root_pattern(
				-- 		'.git',
				-- 		vim.fn.getcwd()
				-- 	), -- this is a temp fix for an error in the lspconfig for this LS
				-- },
				tsserver = {},
				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = 'Replace',
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			require('mason').setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				'stylua',
				'prettierd',
				'angularls',
				'shfmt',
				'markdownlint',
			})
			require('mason-tool-installer').setup({
				ensure_installed = ensure_installed,
			})

			require('mason-lspconfig').setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend(
							'force',
							{},
							capabilities,
							server.capabilities or {}
						)
						require('lspconfig')[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
