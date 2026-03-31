local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('all', {
   s('csipa', { t('Csizmadia Péter András') }),
})

ls.add_snippets('lua', {
   s(
      'plug',
      fmt(
         [[
            ---@type LazyPluginSpec
            return {
               <>
            }
         ]],
         { i(0, '') },
         { delimiters = '<>' }
      )
   ),
   s(
      'plugs',
      fmt(
         [[
            ---@type LazyPluginSpec[]
            return {
               <>
            }
         ]],
         { i(0, '') },
         { delimiters = '<>' }
      )
   ),
})
