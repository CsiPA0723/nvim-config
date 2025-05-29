local ensure_installed = {
   'black',
   'prettierd',
   'pretty-php',
   'shfmt',
   'stylua',
   'termux-language-server',
}

---@type LazyPluginSpec[]
return {
   {
      'stevearc/conform.nvim',
      event = 'BufWritePre',
      opts = {
         notify_on_error = true,
         format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = { c = true, cpp = true }
            return {
               timeout_ms = 1000,
               lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            }
         end,
         formatters_by_ft = {
            lua = { 'stylua' },
            shell = { 'shfmt' },
            bash = { 'shfmt' },
            javascript = { 'prettierd' },
            typescript = { 'prettierd' },
            css = { 'prettierd' },
            scss = { 'prettierd' },
            less = { 'prettierd' },
            html = { 'prettierd' },
            angular = { 'prettierd' },
            ['angular.html'] = { 'prettierd' },
            htmlangular = { 'prettierd' },
            php = { 'pretty-php' },
            c = { 'clang-format' },
            cpp = { 'clang-format' },
         },
      },
      config = function(_, opts)
         for _, format in ipairs(ensure_installed) do
            local installed = require('mason-registry').is_installed(format)
            if not installed then
               vim.notify(
                  format
                     .. ' not installed! Run ":MasonInstall '
                     .. format
                     .. '"',
                  vim.log.levels.ERROR,
                  { group = 'mason' }
               )
            end
         end
         require('conform').setup(opts)
      end,
   },
}
