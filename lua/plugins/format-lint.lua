---@type string[]
local ensure_installed = {
   'black',
   'prettierd',
   'pretty-php',
   'shfmt',
   'stylua',
   'termux-language-server',
   'eslint_d',
   'hadolint',
   'markdownlint',
}

vim.g.lint_warned_about_installs = false

local function warn_about_installs()
   if vim.g.lint_warned_about_installs then
      return
   end
   for _, linter in ipairs(ensure_installed) do
      local installed = require('mason-registry').is_installed(linter)
      if not installed then
         vim.notify(
            linter .. ' not installed! Run ":MasonInstall ' .. linter .. '"',
            vim.log.levels.ERROR,
            { group = 'mason' }
         )
      end
   end
   vim.g.lint_warned_about_installs = true
end

---@type LazyPluginSpec[]
return {
   {
      'mfussenegger/nvim-lint',
      event = { 'BufReadPre', 'BufNewFile' },
      opts = {
         linters_by_ft = {
            markdown = { 'markdownlint' },
            docker = { 'hadolint' },
            javascript = { 'eslint_d' },
            typescript = { 'eslint_d' },
         },
      },
      config = function(_, opts)
         warn_about_installs()
         local lint = require('lint')
         lint.linters_by_ft = opts.linters_by_ft
      end,
   },
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
            python = { 'isort', 'black' },
            rust = { 'rustfmt', lsp_format = 'fallback' },
         },
      },
      config = function(_, opts)
         warn_about_installs()
         require('conform').setup(opts)
      end,
   },
}
