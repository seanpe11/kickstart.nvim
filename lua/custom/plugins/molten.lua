return {
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
}
