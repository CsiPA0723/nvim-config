---@module "blink.cmp"

---@type LazyPluginSpec[]
return {
   {
      'saghen/blink.cmp',
      version = '*',
      event = 'InsertEnter',
      build = 'cargo build --release',
      dependencies = {
         { 'saghen/blink.compat', version = '*', config = true },
         { 'xzbdmw/colorful-menu.nvim', config = true },
         {
            'L3MON4D3/LuaSnip',
            version = '2.*',
            build = 'make install_jsregexp',
            dependencies = {
               {
                  'rafamadriz/friendly-snippets',
                  config = function()
                     require('luasnip.loaders.from_vscode').lazy_load()
                  end,
               },
            },
         },
         {
            'supermaven-inc/supermaven-nvim',
            event = 'InsertEnter',
            cmd = { 'SupermavenUseFree', 'SupermavenUsePro' },
            opts = {
               keymaps = { accept_suggestion = nil },
               disable_inline_completion = true,
            },
         },
      },
      ---@type blink.cmp.Config
      opts = {
         appearance = { nerd_font_variant = 'normal' },
         keymap = {
            preset = 'none',
            ['<C-n>'] = { 'select_next', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback' },
            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            ['<C-y>'] = { 'select_and_accept' },
            ['<C-space>'] = {
               'show',
               'show_documentation',
               'hide_documentation',
            },
            ['<C-l>'] = { 'snippet_forward', 'fallback' },
            ['<C-h>'] = { 'snippet_backward', 'fallback' },
         },
         completion = {
            menu = {
               winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
               draw = {
                  -- We don't need label_description now because label and label_description are already
                  -- conbined together in label by colorful-menu.nvim.
                  columns = { { 'kind_icon' }, { 'label', gap = 1 } },
                  components = {
                     label = {
                        text = function(ctx)
                           return require('colorful-menu').blink_components_text(
                              ctx
                           )
                        end,
                        highlight = function(ctx)
                           return require('colorful-menu').blink_components_highlight(
                              ctx
                           )
                        end,
                     },
                  },
               },
            },
         },
         snippets = { preset = 'luasnip' },
         sources = {
            default = {
               'lazydev',
               'lsp',
               'path',
               'snippets',
               'buffer',
               'supermaven',
               'markdown',
            },
            providers = {
               markdown = {
                  name = 'RenderMarkdown',
                  module = 'render-markdown.integ.blink',
                  fallbacks = { 'lsp' },
                  transform_items = function(_, items)
                     for _, item in ipairs(items) do
                        item.kind_icon = ''
                        item.kind_name = 'RenderMarkdown'
                     end
                     return items
                  end,
               },
               supermaven = {
                  name = 'supermaven',
                  module = 'blink.compat.source',
                  score_offset = 3,
                  async = true,
                  transform_items = function(_, items)
                     for _, item in ipairs(items) do
                        item.kind_icon = ''
                        item.kind_name = 'supermaven'
                     end
                     return items
                  end,
               },
               lazydev = {
                  name = 'LazyDev',
                  module = 'lazydev.integrations.blink',
                  -- NOTE: make lazydev completions top priority (see `:h blink.cmp`)
                  score_offset = 100,
                  transform_items = function(_, items)
                     for _, item in ipairs(items) do
                        item.kind_icon = '󰒲'
                        item.kind_name = 'LazyDev'
                     end
                     return items
                  end,
               },
            },
         },
      },
      opts_extend = { 'sources.default' },
   },
}
