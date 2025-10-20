local filetypes = {
   'css',
   'scss',
   'javascript',
   'typescript',
   'angular',
   'html',
   'angular.html',
   'htmlangular',
}

---@type LazyPluginSpec[]
return {
   {
      'catppuccin/nvim',
      name = 'catppuccin',
      lazy = false,
      priority = 500,
      ---@module "catppuccin"
      ---@type CatppuccinOptions
      opts = {
         compile_path = vim.fn.stdpath('cache') .. '/catppuccin',
         kitty = true,
         flavour = 'macchiato',
         float = { transparent = true, solid = false },
         show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
         term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
         integrations = {
            blink_cmp = true,
            colorful_winsep = {
               enabled = true,
               color = 'red',
            },
            dap = true,
            dap_ui = true,
            diffview = true,
            fidget = true,
            gitsigns = true,
            indent_blankline = {
               enabled = true,
               scope_color = 'lavender',
               colored_indent_levels = true,
            },
            --Lualine.nvim #enabled
            lsp_trouble = true,
            markdown = true,
            mason = true,
            mini = {
               enabled = true,
               indentscope_color = 'lavender',
            },
            neogit = true,
            noice = true,
            notify = true,
            native_lsp = {
               enabled = true,
               virtual_text = {
                  errors = { 'italic' },
                  hints = { 'italic' },
                  warnings = { 'italic' },
                  information = { 'italic' },
               },
               underlines = {
                  errors = { 'underline' },
                  hints = { 'underline' },
                  warnings = { 'underline' },
                  information = { 'underline' },
               },
               inlay_hints = {
                  background = true,
               },
            },
            render_markdown = true,
            snacks = true,
            treesitter = true,
            ufo = true,
            which_key = true,
         },
      },
      config = function(_, opts)
         require('catppuccin').setup(opts)

         local sign = vim.fn.sign_define

         sign(
            'DapBreakpoint',
            { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' }
         )
         sign('DapBreakpointCondition', {
            text = '●',
            texthl = 'DapBreakpointCondition',
            linehl = '',
            numhl = '',
         })
         sign(
            'DapLogPoint',
            { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' }
         )

         vim.cmd.colorscheme('catppuccin')
      end,
   },
   {
      'b0o/incline.nvim',
      event = 'VeryLazy',
      opts = {
         hide = { cursorline = true, only_win = 'count_ignored' },
         window = {
            padding = 0,
            margin = { vertical = 0, horizontal = 0 },
            placement = { vertical = 'top' },
            overlap = {
               borders = true,
               tabline = false,
               winbar = true,
               statusline = true,
            },
         },
      },
      config = function(_, opts)
         local devicons = require('nvim-web-devicons')
         local flavour = require('catppuccin').options.flavour
         local palette = require('catppuccin.palettes').get_palette(flavour)

         opts.render = function(props)
            local filetype = vim.bo[props.buf].filetype
            local names_by_filetypes = { ['oil'] = 'Oil' }
            local filename = vim.tbl_get(names_by_filetypes, filetype)
               or vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
               or ' '
            local ft_icon, ft_color = devicons.get_icon_color(filename)
            local modified = vim.bo[props.buf].modified
            local readonly = vim.bo[props.buf].readonly
            local template = {
               ft_icon and { ' ' .. ft_icon .. ' ', guifg = ft_color } or '',
               ' ',
               filename,
               (modified or readonly) and {
                  ' ',
                  modified and '[+]' or readonly and '[-]' or '',
               } or '',
               ' ',
               guifg = palette.text,
               guibg = palette.surface0,
            }

            if not vim.g.neovide then
               table.insert(template, 1, {
                  '',
                  guifg = palette.surface0,
                  guibg = palette.base,
               })
               table.insert(template, #template + 1, {
                  '',
                  guifg = palette.surface0,
                  guibg = palette.base,
               })
            end
            return template
         end
         require('incline').setup(opts)

         Snacks.toggle
            .new({
               name = 'Incline',
               id = 'incline',
               notify = false,
               which_key = true,
               get = require('incline').is_enabled,
               set = require('incline').toggle,
            })
            :map('<leader>I')
      end,
   },
   {
      'norcalli/nvim-colorizer.lua',
      ft = filetypes,
      config = function()
         require('colorizer').setup(filetypes, {
            RRGGBBAA = true,
            rgb_fn = true,
            hsl_fn = true,
            css = true,
            css_fn = true,
         })
      end,
   },
   {
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = {
         'nvim-treesitter/nvim-treesitter',
         'nvim-tree/nvim-web-devicons',
      },
      cmd = 'RenderMarkdown',
      ft = { 'markdown', 'quarto' },
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {
         completions = { blink = { enabled = true } },
         file_types = { 'markdown', 'quarto' },
      },
   },
}
