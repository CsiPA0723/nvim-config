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
}
