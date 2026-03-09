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
         checkbox = { enabled = false },
         completions = { blink = { enabled = true } },
         file_types = { 'markdown', 'quarto' },
      },
   },
   {
      'bngarren/checkmate.nvim',
      dependencies = {
         'nvim-treesitter/nvim-treesitter',
         'nvim-tree/nvim-web-devicons',
      },
      ft = 'markdown',
      cmd = 'Checkmate',
      ---@module 'checkmate'
      ---@type checkmate.Config
      ---@diagnostic disable-next-line: missing-fields
      opts = {
         files = {
            'todo',
            'TODO',
            'todos',
            'TODOS',
            'todo.md',
            'TODO.md',
            'todos.md',
            'TODOS.md',
            '*.todo',
            '*.TODO',
            '*.todos',
            '*.TODOS',
            '*.todo.md',
            '*.TODO.md',
            '*.todos.md',
            '*.TODOS.md',
         },
         ui = { picker = 'snacks' },
         ---@type table<string,vim.api.keyset.highlight>
         style = {
            CheckmateCancelledMarker = { link = 'Error' },
            CheckmateCancelledMainContent = {
               link = 'CheckmateCheckedMainContent',
            },
            CheckmateInProgressMarker = { link = 'Function' },
            CheckmateInProgressMainContent = { link = 'Normal' },
            CheckmateOnHoldMarker = { link = 'Error' },
            CheckmateOnHoldMainContent = { link = 'Comment' },
         },
         todo_states = {
            ---@diagnostic disable-next-line: missing-fields
            unchecked = { marker = '󰄱 ' },
            ---@diagnostic disable-next-line: missing-fields
            checked = { marker = '󰸞 ' },
            in_progress = {
               marker = '󱎖 ',
               markdown = '.', -- Saved as `- [.]`
               type = 'incomplete', -- Counts as "not done"
               order = 50,
            },
            cancelled = {
               marker = '󰜺 ',
               markdown = 'c', -- Saved as `- [c]`
               type = 'complete', -- Counts as "done"
               order = 2,
            },
            on_hold = {
               marker = '󰏤 ',
               markdown = '/', -- Saved as `- [/]`
               type = 'inactive', -- Ignored in counts
               order = 100,
            },
         },
         metadata = {
            priority = {
               style = function(context)
                  local value = context.value:lower()
                  if value == 'high' then
                     return { fg = '#ff5555', bold = true }
                  elseif value == 'medium' then
                     return { fg = '#ffb86c' }
                  elseif value == 'low' then
                     return { fg = '#8be9fd' }
                  else -- fallback
                     return { fg = '#8be9fd' }
                  end
               end,
               get_value = function()
                  return 'medium' -- Default priority
               end,
               choices = function()
                  return { 'low', 'medium', 'high' }
               end,
               key = '<leader>tp',
               sort_order = 10,
               jump_to_on_insert = 'value',
               select_on_insert = true,
            },
            started = {
               aliases = { 'init' },
               style = { fg = '#9fd6d5' },
               get_value = function()
                  return tostring(os.date('%m/%d/%y %H:%M'))
               end,
               key = '<leader>ts',
               sort_order = 20,
            },
            done = {
               aliases = { 'completed', 'finished' },
               style = { fg = '#96de7a' },
               get_value = function()
                  return tostring(os.date('%m/%d/%y %H:%M'))
               end,
               key = '<leader>td',
               on_add = function(todo)
                  require('checkmate').set_todo_state(todo, 'checked')
               end,
               on_remove = function(todo)
                  require('checkmate').set_todo_state(todo, 'unchecked')
               end,
               sort_order = 30,
            },
         },
         keys = {
            ['<leader>tt'] = {
               rhs = '<cmd>Checkmate toggle<CR>',
               desc = 'Toggle todo item',
               modes = { 'n', 'v' },
            },
            ['<leader>tc'] = {
               rhs = '<cmd>Checkmate check<CR>',
               desc = 'Set todo item as checked (done)',
               modes = { 'n', 'v' },
            },
            ['<leader>tu'] = {
               rhs = '<cmd>Checkmate uncheck<CR>',
               desc = 'Set todo item as unchecked (not done)',
               modes = { 'n', 'v' },
            },
            ['<leader>tk'] = {
               rhs = '<cmd>Checkmate cycle_next<CR>',
               desc = 'Cycle todo item(s) to the next state',
               modes = { 'n', 'v' },
            },
            ['<leader>tj'] = {
               rhs = '<cmd>Checkmate cycle_previous<CR>',
               desc = 'Cycle todo item(s) to the previous state',
               modes = { 'n', 'v' },
            },
            ['<leader>tn'] = {
               rhs = '<cmd>Checkmate create<CR>',
               desc = 'Create todo item',
               modes = { 'n', 'v' },
            },
            ['<leader>tr'] = {
               rhs = '<cmd>Checkmate remove<CR>',
               desc = 'Remove todo marker (convert to text)',
               modes = { 'n', 'v' },
            },
            ['<leader>tR'] = {
               rhs = '<cmd>Checkmate remove_all_metadata<CR>',
               desc = 'Remove all metadata from a todo item',
               modes = { 'n', 'v' },
            },
            ['<leader>ta'] = {
               rhs = '<cmd>Checkmate archive<CR>',
               desc = 'Archive checked/completed todo items (move to bottom section)',
               modes = { 'n' },
            },
            --[[ ['<leader>tF'] = {
               rhs = '<cmd>Checkmate select_todo<CR>',
               desc = 'Open a picker to select a todo from the current buffer',
               modes = { 'n' },
            }, ]]
            ['<leader>tv'] = {
               rhs = '<cmd>Checkmate metadata select_value<CR>',
               desc = 'Update the value of a metadata tag under the cursor',
               modes = { 'n' },
            },
            ['<leader>t]'] = {
               rhs = '<cmd>Checkmate metadata jump_next<CR>',
               desc = 'Move cursor to next metadata tag',
               modes = { 'n' },
            },
            ['<leader>t['] = {
               rhs = '<cmd>Checkmate metadata jump_previous<CR>',
               desc = 'Move cursor to previous metadata tag',
               modes = { 'n' },
            },
         },
      },
   },
}
