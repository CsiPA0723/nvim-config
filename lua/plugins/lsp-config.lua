---@type LazyPluginSpec[]
return {
	{ 'nvim-java/nvim-java', ft = 'java', config = true },
	{
		'pmizio/typescript-tools.nvim',
		ft = {
			'jsx',
			'javascript',
			'typescript',
			'html',
			'typescriptreact',
			'typescript.tsx',
			'angular.html',
			'htmlangular',
		},
		dependencies = 'nvim-lua/plenary.nvim',
		config = true,
	},
	{
		'neovim/nvim-lspconfig',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',
			'b0o/schemastore.nvim',
			{ 'folke/neodev.nvim', config = true },
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			-- NOTE: nvim-ufo setup
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			local servers = {
				lua_ls = {
					settings = { Lua = { completion = { callSnippet = 'Replace' } } },
				},
				angularls = {
					filetypes = {
						'typescript',
						'html',
						'typescriptreact',
						'typescript.tsx',
						'angular.html',
						'htmlangular',
					},
				},
				---@type java.Config
				jdtls = { jdk = { auto_install = false } },
				jsonls = {
					settings = {
						json = {
							schemas = require('schemastore').json.schemas {
								extra = {
									{
										description = 'Pretty-PHP Schema',
										fileMatch = { '.prettyphp', 'prettyphp.json' },
										name = 'prettyphp.json',
										url = 'https://raw.githubusercontent.com/lkrms/pretty-php/main/resources/prettyphp-schema.json',
									},
								},
							},
							validate = { enable = true },
						},
					},
				},
				yamlls = {
					settings = {
						yaml = {
							schemaStore = { enable = false, url = '' },
							schemas = require('schemastore').yaml.schemas(),
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
				'pretty-php',
				'clangd',
				'termux-language-server',
				'black',
				'eslint_d',
				'bash-language-server',
				'clangd',
				'codelldb',
				'cpptools',
				'delve',
				'docker-compose-language-service',
				'glsl_analyzer',
				'hadolint',
				'json-lsp',
				'lua-language-server',
				'php-debug-adapter',
				'phpactor',
				'python-lsp-server',
				'taplo',
				'yaml-language-server',
			})

			require('mason-tool-installer').setup({
				ensure_installed = ensure_installed,
			})

			require('mason-lspconfig').setup({
				automatic_installation = false,
				ensure_installed = {},
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

			vim.api.nvim_create_autocmd({ 'BufEnter' }, {
				pattern = {
					'build.sh',
					'*.subpackage.sh',
					'PKGBUILD',
					'*.install',
					'makepkg.conf',
					'*.ebuild',
					'*.eclass',
					'color.map',
					'make.conf',
				},
				callback = function()
					vim.lsp.start({
						name = 'termux',
						cmd = { 'termux-language-server' },
					})
				end,
			})
		end,
	},
}
