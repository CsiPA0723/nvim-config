local wk = require('which-key')

wk.add({ -- Clipboard
   { '<leader>c', group = 'Clipboard', icon = '󱓦' },
   { '<leader>cp', '"+p', desc = 'Paste down', mode = { 'n', 'v' } },
   { '<leader>cP', '"+P', desc = 'Paste up', mode = { 'n', 'v' } },
   { '<leader>cd', '"+d', desc = 'Delete', mode = { 'n', 'v' } },
   { '<leader>cy', '"+y', desc = 'Copy', mode = { 'n', 'v' } },
   { '<leader>cY', '"+Y', desc = 'Copy' },
})

wk.add({ -- Buffer
   { '<leader>b', group = 'Buffer' },
   { '<leader>bd', Snacks.bufdelete.delete, desc = 'Delete buffer' },
   { '<leader>bD', Snacks.bufdelete.all, desc = 'Delete ALL buffer' },
})

wk.add({ -- Search
   { '<leader>s', group = 'Search' },
   { '<leader>sh', Snacks.picker.help, desc = 'Help' },
   { '<leader>sk', Snacks.picker.keymaps, desc = 'Keymaps' },
   { '<leader>sf', Snacks.picker.files, desc = 'Files' },
   { '<leader>st', Snacks.picker.git_files, desc = 'Git' },
   { '<leader>sw', Snacks.picker.grep_word, desc = 'Current Word' },
   { '<leader>sg', Snacks.picker.grep, desc = 'Grep' },
   { '<leader>sd', Snacks.picker.diagnostics, desc = 'Diagnostics' },
   { '<leader>sr', Snacks.picker.resume, desc = 'Resume' },
   { '<leader>se', Snacks.picker.explorer, desc = 'Explorer' },
   { '<leader>su', Snacks.picker.undo, desc = 'Undotree' },
   { '<leader>si', Snacks.picker.icons, desc = 'Nerd Icon Search' },
   { '<leader>sz', Snacks.picker.zoxide, desc = 'Zoxide list' },
   {
      '<leader>s<leader>',
      Snacks.picker.recent,
      desc = 'Search Recent Files',
   },
   { '<leader>s/', Snacks.picker.grep_buffers, desc = 'in Open Files' },
   {
      '<leader>sn',
      function()
         Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
      end,
      desc = 'Neovim files',
   },
   {
      '<leader>sp',
      function()
         Snacks.picker.files({ cwd = vim.fn.stdpath('data') })
      end,
      desc = 'Neovim plugins',
   },
})

wk.add({ -- Workspace
   { '<leader>w', group = 'Workspace', icon = '' },
   {
      '<leader>wt',
      '<cmd>Trouble todo toggle focus=true win.position=left win.relative=editor<CR>',
      desc = 'Open TODO list',
      icon = '',
   },
})

wk.add({ -- Git
   { '<leader>g', group = 'Git' },
   { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Open Neogit' },
   { '<leader>gc', '<cmd>Neogit commit<CR>', desc = 'Commit' },
   { '<leader>gd', '<cmd>Neogit diff<CR>', desc = 'Diffview' },
   { '<leader>gw', '<cmd>Neogit worktree<CR>', desc = 'Worktree' },
   { '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>', desc = 'Stage Hunk' },
   { '<leader>ga', '<cmd>Gitsigns stage_buffer<CR>', desc = 'Stage Buffer' },
   { '<leader>gB', '<cmd>Gitsigns blame<CR>', desc = 'Blame File' },
   {
      '<leader>gb',
      function()
         Snacks.git.blame_line({ count = 3 })
      end,
      desc = 'Blame Line',
   },
   { '<leader>gl', Snacks.lazygit.open, desc = 'Lazygit' },
})

wk.add({ -- Document
   { '<leader>d', group = 'Document', icon = '󰈙 ' },
   { '<leader>dy', 'ggVG"+y', desc = 'Yank all lines' },
   { '<leader>dP', 'ggVG"+p', desc = 'Paste over all lines' },
   { '<leader>dD', 'ggVG"+d', desc = 'Delete all lines' },
   {
      '<leader>dl',
      function()
         Snacks.picker.pick({
            source = 'files',
            search = 'license(.md|.adoc|.txt)?$',
            confirm = function(self, item)
               self:action('close')
               ---@type string[]
               local file_lines = vim.fn.readfile(item.file)
               table.insert(file_lines, '\n')
               local line_count = vim.tbl_count(file_lines)
               local cursor_previus_pos = vim.api.nvim_win_get_cursor(0)
               cursor_previus_pos[1] = line_count + cursor_previus_pos[1]
               local comment_api = require('Comment.api')
               local comment_config = require('Comment.config'):get()

               vim.api.nvim_win_set_cursor(0, { 1, 0 })
               vim.api.nvim_paste(table.concat(file_lines, '\n'), false, -1)
               vim.api.nvim_buf_set_mark(0, '<', 1, 0, {})
               vim.api.nvim_buf_set_mark(0, '>', line_count - 1, 0, {})
               comment_api.comment.blockwise('V', comment_config)
               vim.api.nvim_win_set_cursor(0, cursor_previus_pos)
               vim.api.nvim_feedkeys(
                  vim.api.nvim_replace_termcodes(
                     '<cmd>write<CR>',
                     true,
                     false,
                     true
                  ),
                  'm',
                  false
               )
               return true
            end,
         })
      end,
      desc = 'Instert License',
   },
})

wk.add({ -- Debug
   { '<F1>', require('dap').step_into, desc = 'Debug: Step Into' },
   { '<F2>', require('dap').step_over, desc = 'Debug: Step Over' },
   { '<F3>', require('dap').step_out, desc = 'Debug: Step Out' },
   { '<F5>', require('dap').continue, desc = 'Debug: Start/Continue' },
   -- NOTE: Toggle to see last session result.
   -- Without this, you can't see session output in case of unhandled exception.
   { '<F7>', require('dapui').toggle, desc = 'Debug: See last session result' },
})

-- Leader prefix
wk.add({
   {
      '<leader>t',
      function()
         if _G.todo_win == nil then
            _G.todo_win = Snacks.win.new({
               file = vim.fn.expand('~/Documents/todos.md'),
               minimal = false,
               backdrop = false,
               width = 0.9,
               height = 0.9,
               zindex = 50,
               resize = true,
               fixbuf = true,
               border = 'rounded',
               bo = { modifiable = true },
               keys = { q = 'close' },
            })
         else
            _G.todo_win:toggle()
         end
      end,
      desc = 'Edit TODOs',
      icon = '',
   },
   {
      '<leader>e',
      vim.diagnostic.open_float,
      desc = 'Show diagnostic Error messages',
   },
   {
      '<leader>P',
      '<cmd>Patterns explain<CR>',
      desc = 'Explain pattern under cursor',
      icon = { icon = '', color = 'orange' },
   },
   {
      '<leader>p',
      '<cmd>Patterns hover<CR>',
      desc = 'See pattern description',
      icon = { icon = '', color = 'orange' },
   },
   {
      '<leader>q',
      '<cmd>Trouble qflist toggle<CR>',
      desc = 'Open diagnostic Quickfix list',
      icon = { icon = '󱖫', color = 'green' },
   },
   {
      '<leader>l',
      '<cmd>Trouble loclist toggle<CR>',
      desc = 'Location list',
      icon = { icon = '󱖫', color = 'green' },
   },
   {
      '<leader>L',
      '<cmd>Lazy<cr>',
      desc = 'Open Lazy Plugin Manager',
      icon = '󰒲',
   },
   { '<leader>M', '<cmd>Mason<cr>', desc = 'Open Mason', icon = '' },
   {
      '<leader>h',
      Snacks.dashboard.open,
      desc = 'Open Dashboard',
      icon = '',
   },
   { '<leader>o', '<cmd>Oil<cr>', desc = 'Open Oil', icon = '󱁓' },
   {
      '<leader>F',
      function()
         require('conform').format({ async = true, lsp_fallback = true })
      end,
      desc = 'Format buffer',
   },
   {
      '<leader><leader>',
      Snacks.picker.buffers,
      desc = 'Find existing buffers',
   },
   {
      '<ledaer>/',
      Snacks.picker.lines,
      desc = 'Fuzzily search in current buffer',
   },
   {
      '<leader>K',
      function()
         local winid = require('ufo').peekFoldedLinesUnderCursor()
         if not winid then
            vim.lsp.buf.hover()
         end
      end,
      desc = 'Ufo: Peek Folded Lines Under Cursor',
      icon = '',
   },
})

wk.add({ -- Misc
   { --  Move lines
      mode = 'v',
      { 'J', ":m '>+1<cr>gv=gv", desc = 'Move selected down' },
      { 'K', ":m '<-2<cr>gv=gv", desc = 'Move selected up' },
   },
   { -- Search within visual selection
      mode = 'x',
      {
         'z/',
         '<C-\\><C-n>`</\\%V',
         desc = 'Search forward within visual selection',
      },
      {
         'z?',
         '<C-\\><C-n>`>?\\%V',
         desc = 'Search backward within visual selection',
      },
   },
   { '<Esc>', '<cmd>nohlsearch<cr>', desc = 'Cancel active highlight' },
   -- Leaves the cursor in the same place
   { 'J', 'mzJ`z', desc = 'Join line' },
   { -- Tries to keep the cursor at the center
      { '<C-d>', '<C-d>zz' },
      { '<C-u>', '<C-u>zz' },
      { 'n', 'nzzzv' },
      { 'N', 'Nzzzv' },
   },
   { '<C-space>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' },
})
