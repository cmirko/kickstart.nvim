return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {}
    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end
      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end
    -- Keymaps
    vim.keymap.set('n', '<leader>lh', function()
      toggle_telescope(harpoon:list())
    end, { desc = '[L]ist [H]arpoon files' })
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = '[A]dd file to harpoon list' })
    vim.keymap.set('n', '<C-u>', function()
      harpoon:list():select(1)
    end, { desc = 'Go to 1st file in harpoon list' })
    vim.keymap.set('n', '<C-i>', function()
      harpoon:list():select(2)
    end, { desc = 'Go to 2nd file in harpoon list' })
    vim.keymap.set('n', '<C-o>', function()
      harpoon:list():select(3)
    end, { desc = 'Go to 3rd file in harpoon list' })
    vim.keymap.set('n', '<C-ò>', function()
      harpoon:list():select(4)
    end, { desc = 'Go to 4th file in harpoon list' })
    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<C-S-P>', function()
      harpoon:list():prev()
    end, { desc = 'Go to previous file in harpoon list' })
    vim.keymap.set('n', '<C-S-N>', function()
      harpoon:list():next()
    end, { desc = 'Go to next file in harpoon list' })
  end,
}
