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
		dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
		config = true,
	},
	{
		'folke/lazydev.nvim',
		ft = 'lua', -- only load on lua files
		opts = {
			---@module "lazydev"
			---@type lazydev.Library.spec[]
			library = {
				'lazy.nvim',
				{ path = 'snacks.nvim', words = { 'snacks', 'Snacks' } },
				{ path = 'task-runner.nvim', words = { 'TaskRunner', 'task-runner' } },
				{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
			},
		},
	},
	{
		'neovim/nvim-lspconfig',
		event = 'VeryLazy',
		dependencies = {
			'mason-org/mason.nvim',
			'mason-org/mason-lspconfig.nvim',
			'b0o/schemastore.nvim',
		},
		config = function()
			require('mason').setup()

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
						'htmlangular',
					},
				},
				bashls = { settings = { filetypes = { 'sh', 'zsh' } } },
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

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				'angularls',
				'bashls',
				'clangd',
				'cssls',
				'docker_compose_language_service',
				'glsl_analyzer',
				-- 'htmx',
				'jdtls',
				'jsonls',
				'lua_ls',
				'phpactor',
				'pylsp',
				'taplo',
				'yamlls',
			})

			require('mason-lspconfig').setup({
				automatic_enable = { exclude = { 'ts_ls' } },
				ensure_installed = ensure_installed,
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
