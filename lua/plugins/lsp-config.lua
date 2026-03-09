---@type LazyPluginSpec[]
return {
   {
      'folke/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      opts = {
         ---@module "lazydev"
         ---@type lazydev.Library.spec[]
         library = {
            'lazy.nvim',
            { path = 'snacks.nvim', words = { 'snacks', 'Snacks' } },
            {
               path = 'task-runner.nvim',
               words = { 'TaskRunner', 'task-runner' },
            },
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
         },
      },
   },
   {
      'mason-org/mason-lspconfig.nvim',
      event = 'VeryLazy',
      dependencies = {
         'mason-org/mason.nvim',
         'neovim/nvim-lspconfig',
      },
      ---@module 'mason-lspconfig'
      ---@type MasonLspconfigSettings
      opts = { ensure_installed = { 'lua_ls@3.16.4' } },
   },
   {
      'neovim/nvim-lspconfig',
      dependencies = {
         'b0o/schemastore.nvim',
         {
            'seblyng/roslyn.nvim',
            ---@module 'roslyn.config'
            ---@type RoslynNvimConfig
            opts = { broad_search = false },
         },
      },
      config = function()
         ---@type table<string,vim.lsp.Config>
         local lsp_configs = {
            bashls = { settings = { filetypes = { 'sh', 'zsh' } } },
            jsonls = {
               settings = {
                  json = {
                     schemas = require('schemastore').json.schemas({
                        extra = {
                           {
                              description = 'Pretty-PHP Schema',
                              fileMatch = { '.prettyphp', 'prettyphp.json' },
                              name = 'prettyphp.json',
                              url = 'https://raw.githubusercontent.com/lkrms/pretty-php/main/resources/prettyphp-schema.json',
                           },
                        },
                     }),
                     validate = { enable = true },
                  },
               },
            },
            lua_ls = {
               settings = {
                  Lua = {
                     -- ISSUE: https://github.com/folke/lazydev.nvim/issues/136
                     -- Keep lua-language-server at 3.16.4
                     --[[ workspace = {
                        library = vim.api.nvim_get_runtime_file('', true),
                     }, ]]
                     telemetry = { enable = false },
                     completion = { callSnippet = 'Replace' },
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
            termux = {
               cmd = { 'termux-language-server' },
            },
         }

         for lsp_name, lsp_config in pairs(lsp_configs) do
            vim.lsp.config(lsp_name, lsp_config)
         end

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
               vim.lsp.enable('termux')
            end,
         })
      end,
   },
}
