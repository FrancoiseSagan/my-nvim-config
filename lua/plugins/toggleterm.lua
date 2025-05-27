return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
  
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end
  
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  
      local Terminal = require('toggleterm.terminal').Terminal
  
      local compile = Terminal:new({
        cmd = "gcc -o %:r %",
        hidden = true,
        close_on_exit = false,
        direction = "float",
      })
  
      local run = Terminal:new({
        cmd = "./%:r",
        hidden = true,
        direction = "float",
      })
  
      vim.keymap.set('n', '<F5>', function()
        vim.cmd('write')
        compile:toggle()
      end, {noremap = true, silent = true})
  
      vim.keymap.set('n', '<F6>', function()
        run:toggle()
      end, {noremap = true, silent = true})
    end,
  }