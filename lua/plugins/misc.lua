---@type LazyPluginSpec[]
return {
   -- Shared dependencies {{{
   { 'nvim-treesitter/nvim-treesitter', branch = 'master', optional = true },
   {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'master',
      optional = true,
   },
   { 'nvim-tree/nvim-web-devicons', optional = true },
   { 'nvim-lua/plenary.nvim', optional = true },
   -- }}}
   { 'neolooong/whichpy.nvim', ft = 'python', config = true },
   { 'fladson/vim-kitty', ft = 'kitty' },
   { 'ThePrimeagen/vim-be-good', cmd = 'VimBeGood' },
   { 'nvim-zh/colorful-winsep.nvim', event = 'WinLeave', config = true },
   { 'dundalek/bloat.nvim', cmd = 'Bloat' },
   {
      'nvzone/timerly',
      dependencies = { 'nvzone/volt' },
      cmd = 'TimerlyToggle',
      config = true,
   },
   {
      'CsiPA0723/which-key.nvim', -- Temporary fork
      lazy = false,
      ---@module "which-key"
      ---@type wk.Opts
      opts = { preset = 'modern', win = { no_overlap = false }, delay = 500 },
   },
   {
      'mistricky/codesnap.nvim',
      cmd = { 'CodeSnap', 'CodeSnapSave' },
      build = 'make build_generator',
   },
   {
      'cuducos/yaml.nvim',
      ft = 'yaml',
      dependencies = 'nvim-treesitter/nvim-treesitter',
   },
   {
      'folke/trouble.nvim',
      dependencies = 'nvim-tree/nvim-web-devicons',
      cmd = 'Trouble',
      config = true,
   },
   {
      'OXY2DEV/patterns.nvim',
      dependencies = 'nvim-treesitter/nvim-treesitter',
      cmd = 'Patterns',
   },
   {
      'OXY2DEV/helpview.nvim',
      ft = 'help',
      dependencies = 'nvim-treesitter/nvim-treesitter',
   },
   {
      'CsiPA0723/task-runner.nvim',
      dev = true,
      dir = '/home/csipa/Projects/Personal/task-runner.nvim',
      event = 'VeryLazy',
      dependencies = { 'folke/snacks.nvim' },
      ---@type TaskRunner.config
      opts = {
         options = {
            tasks_dir = '/home/csipa/Projects/Personal/task-runner.nvim/examples',
         },
      },
      config = function(_, opts)
         require('fidget.notification').set_config('TaskRunner', {
            name = 'TaskRunner',
            icon = ' ',
            ttl = 4,
         }, true)
         require('task-runner').setup(opts)
      end,
   },
   {
      'CsiPA0723/i18n.nvim',
      dev = true,
      dir = '/home/csipa/Projects/Personal/i18n.nvim',
      event = 'VeryLazy',
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      ---@type i18n.config
      opts = {},
      config = function(_, opts)
         require('fidget.notification').set_config('i18n', {
            name = 'i18n',
            icon = ' ',
            ttl = 4,
         }, true)
         require('i18n').setup(opts)
      end,
   },
}
