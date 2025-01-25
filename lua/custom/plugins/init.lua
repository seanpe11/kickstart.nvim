-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'akinsho/toggleterm.nvim',
    version = '',
    init = function()
      require('toggleterm').setup {
        open_mapping = [[<C-\>]],
        size = 20,
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 0,
          highlights = {
            border = 'Normal',
            background = 'Normal',
          },
        },
      }
    end,
    config = function()
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new { cmd = 'lazygit', hidden = true }

      function _lazygit_toggle()
        lazygit:toggle()
      end

      local vertical = Terminal:new { hidden = true, direction = 'vertical' }
      function vertical_toggle()
        vertical:toggle()
      end
      vim.api.nvim_set_keymap('n', '<C-?>', '<cmd>lua vertical_toggle()<CR>', { noremap = true, silent = true, desc = '[L]azy [V]ertical toggle' })

      vim.api.nvim_set_keymap('n', '<leader>lg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true, desc = '[L]azy[G]it toggle' })
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {}
      local api = require 'nvim-tree.api'

      -- keymaps
      vim.keymap.set('n', '<leader>e', api.tree.toggle, { desc = 'Show NvimTree' })
    end,
  },
  {
    '3rd/image.nvim',
  },
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    dependencies = { '3rd/image.nvim' },
    build = ':UpdateRemotePlugins',
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.keymap.set('n', '<localleader>mi', ':MoltenInit<CR>', { silent = true, desc = '[M]olten[I]nitialize the plugin' })
      vim.keymap.set('n', '<localleader>ml', ':MoltenEvaluateLine<CR>', { silent = true, desc = '[M]oltenEvaluate[L]ine' })
      vim.keymap.set('n', '<localleader>mr', ':MoltenReevaluateCell<CR>', { silent = true, desc = 're-evaluate cell' })
      vim.keymap.set('v', '<localleader>m', ':<C-u>MoltenEvaluateVisual<CR>gv', { silent = true, desc = '[M]oltenEvaluateVisual' })
    end,
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      local harpoon = require 'harpoon'

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Harpoon [a]dd' })
      vim.keymap.set('n', '<A-Tab>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon List [Tab]' })

      vim.keymap.set('n', '<A-1>', function()
        harpoon:list():select(1)
      end, { desc = 'H<Alt>rpoon [1]Select' })
      vim.keymap.set('n', '<A-2>', function()
        harpoon:list():select(2)
      end, { desc = 'H<Alt>rpoon [2]Select' })
      vim.keymap.set('n', '<A-3>', function()
        harpoon:list():select(3)
      end, { desc = 'H<Alt>rpoon [3]Select' })
      vim.keymap.set('n', '<A-4>', function()
        harpoon:list():select(4)
      end, { desc = 'H<Alt>rpoon [4]Select' })
      vim.keymap.set('n', '<A-5>', function()
        harpoon:list():select(5)
      end, { desc = 'H<Alt>rpoon [5]Select' })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<A-h>', function()
        harpoon:list():prev()
      end, { desc = 'H<Alt>rpoon [h]prev' })
      vim.keymap.set('n', '<A-l>', function()
        harpoon:list():next()
      end, { desc = 'H<Alt>rpoon [l]next' })
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {
      init = function()
        local npairs = require 'nvim-autopairs'
        local Rule = require 'nvim-autopairs.rule'
        local cond = require 'nvim-autopairs.conds'

        npairs.setup {}

        npairs.add_rules {
          Rule('$', '$', 'tex'):with_pair(cond.not_after_text '$'):with_move(cond.after_text '$'):with_move(cond.before_text '$'),
          Rule('$$', '$$', 'tex'):with_pair(cond.after_text '$'):with_move(cond.after_text '$$'):with_move(cond.before_text '$$'),
        }
      end,
    },
  },
}
