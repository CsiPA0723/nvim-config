---@type LazyPluginSpec
return {
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
}
