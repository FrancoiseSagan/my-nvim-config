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
  
      -- F5: Compile current C/C++ file
      vim.keymap.set('n', '<F5>', function()
        local current_file = vim.fn.expand('%')
        local file_extension = vim.fn.expand('%:e')
        
        -- Check if current buffer has a filename
        if current_file == '' then
          vim.notify("No file to compile. Please save the file first.", vim.log.levels.WARN)
          return
        end
        
        -- Check if it's a C/C++ file
        if file_extension ~= 'c' and file_extension ~= 'cpp' and file_extension ~= 'cxx' and file_extension ~= 'cc' then
          vim.notify("Current file is not a C/C++ file.", vim.log.levels.WARN)
          return
        end
        
        -- Auto-save the file before compiling
        if vim.bo.modified then
          vim.cmd('write')
          vim.notify("File saved automatically before compilation.", vim.log.levels.INFO)
        end
        
        -- Build compile command dynamically
        local output_name = vim.fn.expand('%:r')  -- filename without extension
        local compile_cmd
        
        if file_extension == 'cpp' or file_extension == 'cxx' or file_extension == 'cc' then
          compile_cmd = string.format("g++ -o %s %s", output_name, current_file)
        else
          compile_cmd = string.format("gcc -o %s %s", output_name, current_file)
        end
        
        -- Create compilation terminal
        local compile_terminal = Terminal:new({
          cmd = compile_cmd,
          hidden = true,
          close_on_exit = false,
          direction = "float",
          on_exit = function(_, _, exit_code)
            if exit_code == 0 then
              vim.notify("Compilation successful!", vim.log.levels.INFO)
            else
              vim.notify("Compilation failed!", vim.log.levels.ERROR)
            end
          end,
        })
        
        vim.notify("Compiling " .. current_file .. "...", vim.log.levels.INFO)
        compile_terminal:toggle()
      end, {noremap = true, silent = true})
  
      -- F6: Run compiled program
      vim.keymap.set('n', '<F6>', function()
        local current_file = vim.fn.expand('%')
        local file_extension = vim.fn.expand('%:e')
        
        -- Check if it's a C/C++ file
        if file_extension ~= 'c' and file_extension ~= 'cpp' and file_extension ~= 'cxx' and file_extension ~= 'cc' then
          vim.notify("Current file is not a C/C++ file.", vim.log.levels.WARN)
          return
        end
        
        local output_name = vim.fn.expand('%:r')
        
        -- Check if executable exists
        if vim.fn.filereadable(output_name) == 0 then
          vim.notify("Executable not found. Please compile first (F5).", vim.log.levels.WARN)
          return
        end
        
        -- Create run terminal
        local run_terminal = Terminal:new({
          cmd = "./" .. output_name,
          hidden = true, 
          direction = "float",
          close_on_exit = false,
        })
        
        vim.notify("Running " .. output_name .. "...", vim.log.levels.INFO)
        run_terminal:toggle()
      end, {noremap = true, silent = true})
    end,
  }