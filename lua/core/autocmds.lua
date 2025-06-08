local wk = require('which-key')

autocmd('TextYankPost', {
   desc = 'Highlight when yanking (copying) text',
   group = augroup('csipa-highlight-yank', { clear = true }),
   callback = function()
      vim.hl.on_yank()
   end,
})

autocmd('LspAttach', {
   desc = 'LSP actions',
   group = augroup('csipa-lsp-attach', { clear = true }),
   callback = function(event)
      -- TODO: Revise this section
      wk.add({
         { -- Actions
            {
               'grr',
               '<cmd>Trouble lsp_references toggle focus=true<CR>',
               desc = 'LSP: Reference(s)',
            },
            {
               'gri',
               '<cmd>Trouble lsp_implementations toggle focus=true<CR>',
               desc = 'LSP: Implementation(s)',
            },
            {
               'grd',
               '<cmd>Trouble lsp_definitions toggle focus=true<CR>',
               desc = 'LSP: Definition',
            },
            {
               'grD',
               '<cmd>Trouble lsp_declarations toggle focus=true<CR>',
               desc = 'LSP: Declaration',
            },
            {
               'grt',
               '<cmd>Trouble lsp_type_definitions toggle focus=true<CR>',
               desc = 'LSP: Type Definition(s)',
            },
            { 'grn', vim.lsp.buf.rename, desc = 'LSP: Rename' },
            { 'gra', vim.lsp.buf.code_action, desc = 'LSP: Code Action' },
         },
         { -- Document
            {
               '<leader>ds',
               '<cmd>Trouble lsp_document_symbols toggle focus=false win.position=left win.relative=editor win.type=split<CR>',
               desc = 'LSP: Document Symbols',
            },
         },
         { -- Workspace
            {
               '<leader>wS',
               Snacks.picker.lsp_workspace_symbols,
               desc = 'LSP: Workspace Symbols',
            },
            {
               '<leader>wl',
               '<cmd>Trouble lsp toggle focus=false win.position=left win.relative=editor win.type=split<CR>',
               desc = 'LSP: Definitions / Referencies / ...',
            },
         },
         { 'K', vim.lsp.buf.hover, desc = 'LSP: Hover Documentation' },
         buffer = event.buf,
      })

      local client = vim.lsp.get_client_by_id(event.data.client_id)

      --[[ INFO: 
    --  The following two autocommands are used to highlight references of the
    --  word under your cursor when your cursor rests there for a little while.
    --  When you move your cursor, the highlights will be cleared (the second autocommand).
    --]]
      if client and client.server_capabilities.documentHighlightProvider then
         local group = augroup('highlight-references', { clear = true })
         autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = group,
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
         })

         autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = group,
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
         })
      end

      if
         client and client:supports_method('textDocument/codeLens', event.buf)
      then
         autocmd({ 'TextChanged', 'InsertLeave', 'CursorHold', 'LspAttach' }, {
            buffer = event.buf,
            callback = function()
               vim.lsp.codelens.refresh({ bufnr = event.buf })
            end,
         })

         -- trigger codelens refresh
         vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
      end
   end,
})

autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
   group = augroup('lint', { clear = true }),
   callback = function()
      require('lint').try_lint()
   end,
})

autocmd('FileType', {
   pattern = {
      'checkhealth',
      'git',
      'gitsigns-blame',
      'help',
      'lspinfo',
      'netrw',
      'notify',
      'qf',
      'query',
   },
   group = augroup('csipa-quick-quit', { clear = true }),
   callback = function()
      wk.add({ 'q', vim.cmd.close, desc = 'Close active buffer', buffer = true })
   end,
})

autocmd('FileType', {
   pattern = { 'help', 'Neogit*' },
   group = augroup('csipa-colorcolum', { clear = true }),
   callback = function()
      vim.opt_local.colorcolumn = ''
   end,
})

autocmd('TermOpen', {
   desc = 'Disable some featuers in a terminal buffer',
   group = augroup('csipa-term-open', { clear = true }),
   callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.colorcolumn = ''
   end,
})

local session_group = augroup('csipa-session', { clear = true })

autocmd({ 'User' }, {
   pattern = 'PersistenceSavePost',
   desc = 'Notify user the session is saved',
   group = session_group,
   callback = function()
      vim.notify(
         vim.fn.getcwd(),
         vim.log.levels.INFO,
         { group = 'session', annote = 'Saved' }
      )
   end,
})

autocmd({ 'User' }, {
   pattern = 'PersistenceLoadPre',
   desc = 'Clear lsps before loading new session',
   group = session_group,
   callback = function()
      vim.lsp.stop_client(vim.lsp.get_clients(), true)
      vim.notify(
         vim.fn.getcwd(),
         vim.log.levels.INFO,
         { group = 'session', annote = 'Loading...', key = 'session_load' }
      )
   end,
})

autocmd({ 'User' }, {
   pattern = 'PersistenceLoadPost',
   desc = 'Notify user the session is loaded and start lsps',
   group = session_group,
   callback = function()
      vim.notify(
         vim.fn.getcwd(),
         vim.log.levels.INFO,
         { group = 'session', annote = 'Loaded', key = 'session_load' }
      )
   end,
})

autocmd('DirChanged', {
   pattern = '*',
   group = augroup('dashboard_on_dir_change', { clear = true }),
   callback = function()
      if Snacks.dashboard.status.opened then
         Snacks.dashboard.update()
      end
   end,
})
