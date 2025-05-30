local function ai(direction, id)
   local count = vim.v.count
   vim.cmd('norm! m`')
   repeat
      MiniAi.move_cursor('left', 'a', id, { search_method = direction })
      count = count - 1
   until count <= 0
end

---@type LazyPluginSpec[]
return {
   {
      'echasnovski/mini.ai',
      dependencies = {
         'echasnovski/mini.extra',
         'nvim-treesitter/nvim-treesitter-textobjects',
      },
      event = 'BufRead',
      config = function(_, opts)
         local gen_spec = require('mini.ai').gen_spec
         local gen_spec_extra = require('mini.extra').gen_ai_spec

         local custom_objects = {
            a = {
               name = 'Argument',
               spec = gen_spec.argument({ separator = '[,;]' }),
               add_jump = true,
            },
            b = {
               name = 'Bracket',
               spec = { { '%b()', '%b[]', '%b{}' }, '^.().*().$' },
            },
            c = {
               name = 'Comment',
               spec = gen_spec.treesitter({
                  a = { '@comment.outer' },
                  i = { '@comment.inner' },
               }),
            },
            d = {
               name = 'Digits',
               spec = gen_spec_extra.number(),
            },
            e = {
               name = 'Diagnostic',
               spec = gen_spec_extra.diagnostic(),
               add_jump = true,
            },
            f = {
               name = 'Function call (no dot)',
               spec = gen_spec.function_call({ name_pattern = '[%w_]' }),
               add_jump = true,
            },
            F = {
               name = 'Function call (full)',
               spec = gen_spec.treesitter({
                  i = { '@call.inner' },
                  a = { '@call.outer' },
               }),
               add_jump = true,
            },
            g = {
               name = 'Sentence',
               spec = {
                  {
                     '%b{}',
                     '\n%s*\n()().-()\n%s*\n[%s]*()', -- normal paragraphs
                     '^()().-()\n%s*\n[%s]*()', -- paragraph at start of file
                     '\n%s*\n()().-()()$', -- paragraph at end of file
                  },
                  {
                     '[%.?!][%s]+()().-[^%s].-()[%.?!]()[%s]', -- normal sentence
                     '^[%{%[]?[%s]*()().-[^%s].-()[%.?!]()[%s]', -- sentence at start of paragraph
                     '[%.?!][%s]+()().-[^%s].-()()[\n%}%]]?$', -- sentence at end of paragraph
                     '^[%s]*()().-[^%s].-()()[%s]+$', -- sentence at that fills paragraph (no final punctuation)
                  },
               },
               add_jump = true,
            },
            -- Hunks
            i = {
               name = 'Indent',
               spec = gen_spec_extra.indent(),
               add_jump = true,
            },
            -- Jumps
            k = {
               name = 'Key',
               spec = gen_spec.treesitter({
                  i = { '@assignment.lhs', '@key.inner' },
                  a = { '@assignment.outer', '@key.inner' },
               }),
            },
            -- List (trouble)
            m = {
               name = 'Notebook cell',
               spec = gen_spec.treesitter({
                  a = { '@block.outer' },
                  i = { '@block.inner' },
               }),
               add_jump = true,
            },
            o = {
               name = 'Block',
               spec = gen_spec.treesitter({
                  a = { '@block.outer', '@conditional.outer', '@loop.outer' },
                  i = { '@block.inner', '@conditional.inner', '@loop.inner' },
               }),
               add_jump = true,
            },
            p = {
               name = 'Paragraph',
               spec = {
                  {
                     '\n%s*\n()().-()\n%s*\n()[%s]*', -- normal paragraphs
                     '^()().-()\n%s*\n[%s]*()', -- paragraph at start of file
                     '\n%s*\n()().-()()$', -- paragraph at end of file
                  },
               },
               add_jump = true,
            },
            q = {
               name = 'Quotes',
               spec = { { "%b''", '%b""', '%b``' }, '^.().*().$' },
            },
            r = {
               name = 'Sub-word',
               spec = {
                  {
                     '%u[%l%d]+%f[^%l%d]',
                     '%f[%S][%l%d]+%f[^%l%d]',
                     '%f[%P][%l%d]+%f[^%l%d]',
                     '^[%l%d]+%f[^%l%d]',
                  },
                  '^().*()$',
               },
            },
            s = {
               name = 'Scope',
               spec = gen_spec.treesitter({
                  a = { '@function.outer', '@class.outer', '@testitem.outer' },
                  i = { '@function.inner', '@class.inner', '@testitem.inner' },
               }),
               add_jump = true,
            },
            t = {
               name = 'Tag',
               spec = { '<(%w-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
            },
            v = {
               name = 'Value',
               spec = gen_spec.treesitter({
                  i = { '@assignment.rhs', '@value.inner', '@return.inner' },
                  a = { '@assignment.outer', '@value.inner', '@return.outer' },
               }),
            },
            W = {
               name = 'Big word',
               spec = {
                  {
                     '()()%f[%w%p][%w%p]+()[ \t]*()',
                  },
               },
            },
            -- word
            w = {
               name = 'Word',
               spec = { '()()%f[%w_][%w_]+()[ \t]*()' },
            },
            x = {
               name = 'Line',
               spec = gen_spec_extra.line(),
            },
            z = {
               name = 'Chunk',
               spec = {
                  '\n.-%b{}.-\n',
                  '\n().-()%{\n.*\n.*%}().-\n()',
               },
            },
            ['$'] = {
               name = 'Maths',
               spec = gen_spec.pair('$', '$', { type = 'balanced' }),
               add_jump = true,
            },
            -- ? user prompt object
         }

         require('mini.ai').setup(vim.tbl_deep_extend('force', opts or {}, {
            custom_textobjects = vim.tbl_map(function(v)
               return v.spec
            end, custom_objects),
            mappings = {
               around = 'a',
               inside = 'i',
               around_next = 'an',
               inside_next = 'in',
               around_last = 'al',
               inside_last = 'il',
               goto_left = '{',
               goto_right = '}',
            },
            n_lines = 500,
            search_method = 'cover_or_nearest',
         }))

         for k, v in pairs(custom_objects) do
            if v.add_jump then
               vim.keymap.set({ 'n', 'x', 'o' }, '[' .. k, function()
                  ai('prev', k)
               end, { desc = v.name })
               vim.keymap.set({ 'n', 'x', 'o' }, ']' .. k, function()
                  ai('next', k)
               end, { desc = v.name })
            end
         end
      end,
   },
   { 'echasnovski/mini.align', event = 'BufRead', config = true },
   { 'echasnovski/mini.surround', event = 'BufRead', config = true },
}
