---@type string[]
local ensure_installed = {
   'eslint_d',
   'hadolint',
   'markdownlint',
}

---@type LazyPluginSpec[]
return {
   { -- Linting
      'mfussenegger/nvim-lint',
      event = { 'BufReadPre', 'BufNewFile' },
      config = function()
         for _, linter in ipairs(ensure_installed) do
            local installed = require('mason-registry').is_installed(linter)
            if not installed then
               vim.notify(
                  linter
                     .. ' not installed! Run ":MasonInstall '
                     .. linter
                     .. '"',
                  vim.log.levels.ERROR,
                  { group = 'mason' }
               )
            end
         end
         local lint = require('lint')
         lint.linters_by_ft = {
            markdown = { 'markdownlint' },
            docker = { 'hadolint' },
            javascript = { 'eslint_d' },
            typescript = { 'eslint_d' },
         }
      end,
   },
}
