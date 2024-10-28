-- Bootstrap lazy.nvim, LazyVim, and your plugins
require("config.lazy")

require("lazy").setup({
  rocks = { enabled = false },

  -- LazyVim framework
  { "LazyVim/LazyVim", config = true },

  -- Core TypeScript/JavaScript support
  { "neovim/nvim-lspconfig" },
  { "jose-elias-alvarez/nvim-lsp-ts-utils" },

  -- Autocompletion setup
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  { "alexghergh/nvim-tmux-navigation" },

  -- Syntax highlighting using Treesitter
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },

  -- Productivity plugins
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" },
  { "nvim-lualine/lualine.nvim" },
  { "lewis6991/gitsigns.nvim" },
  { "terrortylor/nvim-comment" },
  { "windwp/nvim-autopairs" },
  { "tpope/vim-surround" },

  -- null-ls setup for Prettier and auto-formatting on save
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Prettier for formatting
          null_ls.builtins.formatting.prettier,
        },

        -- Autoformat on save
        on_attach = function(client, bufnr)
          if client.resolved_capabilities.document_formatting then
            vim.api.nvim_command([[augroup Format]])
            vim.api.nvim_command([[autocmd! * <buffer>]])
            vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])
            vim.api.nvim_command([[augroup END]])
          end
        end,
      })
    end,
  },
})

-- Configure TypeScript/JavaScript LSP
local lspconfig = require("lspconfig")
lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  end,
})

-- Optional AI Assistant (uncomment to enable GitHub Copilot integration)
-- { "github/copilot.vim" },

-- Telescope setup for fuzzy finding
require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "node_modules/.*", "%.git/.*", "dist/.*", ".next/.*" },
    mappings = {
      i = {
        ["<C-n>"] = require("telescope.actions").move_selection_next,
        ["<C-p>"] = require("telescope.actions").move_selection_previous,
      },
    },
  },
})

-- Treesitter configuration
require("nvim-treesitter.configs").setup({
  ensure_installed = { "typescript", "javascript", "html", "css", "json" }, -- Add more languages as needed
  highlight = { enable = true },
})

vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
