return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<C-t>]], -- Keybinding to toggle terminal
      shade_filetypes = {}, -- Disable shading for specific filetypes
      shading_factor = 2, -- Shading intensity (1-3)
      direction = "vertical", -- Options: 'horizontal', 'vertical', 'float'
      width = 80, -- Width of the terminal
      float_opts = { -- Customize floating window appearance
        border = "curved",
        winblend = 3,
      },
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return 80
        end
      end,
    })

    -- Custom terminal example for lazygit
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>n", ":ToggleTermToggleAll<CR>", { noremap = true, silent = true })

    -- Terminal navigation mappings
    vim.cmd([[
      tnoremap <Esc> <C-\><C-n>
      tnoremap <C-h> <C-\><C-n><C-w>h
      tnoremap <C-j> <C-\><C-n><C-w>j
      tnoremap <C-k> <C-\><C-n><C-w>k
      tnoremap <C-l> <C-\><C-n><C-w>l
    ]])
  end,
}
