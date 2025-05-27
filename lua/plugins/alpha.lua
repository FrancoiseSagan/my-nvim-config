return {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      local alpha = require'alpha'
      local dashboard = require'alpha.themes.dashboard'
  
      dashboard.section.header.val = {
        [[  █████▒██▀███   ▄▄▄       ███▄    █  ▄████▄   ▒█████   ██▓  ██████ ▓█████      ██████  ▄▄▄        ▄████  ▄▄▄       ███▄    █ ]],
        [[▓██   ▒▓██ ▒ ██▒▒████▄     ██ ▀█   █ ▒██▀ ▀█  ▒██▒  ██▒▓██▒▒██    ▒ ▓█   ▀    ▒██    ▒ ▒████▄     ██▒ ▀█▒▒████▄     ██ ▀█   █ ]],
        [[▒████ ░▓██ ░▄█ ▒▒██  ▀█▄  ▓██  ▀█ ██▒▒▓█    ▄ ▒██░  ██▒▒██▒░ ▓██▄   ▒███      ░ ▓██▄   ▒██  ▀█▄  ▒██░▄▄▄░▒██  ▀█▄  ▓██  ▀█ ██▒]],
        [[░▓█▒  ░▒██▀▀█▄  ░██▄▄▄▄██ ▓██▒  ▐▌██▒▒▓▓▄ ▄██▒▒██   ██░░██░  ▒   ██▒▒▓█  ▄      ▒   ██▒░██▄▄▄▄██ ░▓█  ██▓░██▄▄▄▄██ ▓██▒  ▐▌██▒]],
        [[░▒█░   ░██▓ ▒██▒ ▓█   ▓██▒▒██░   ▓██░▒ ▓███▀ ░░ ████▓▒░░██░▒██████▒▒░▒████▒   ▒██████▒▒ ▓█   ▓██▒░▒▓███▀▒ ▓█   ▓██▒▒██░   ▓██░]],
        [[ ▒ ░   ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░░ ▒░   ▒ ▒ ░ ░▒ ▒  ░░ ▒░▒░▒░ ░▓  ▒ ▒▓▒ ▒ ░░░ ▒░ ░   ▒ ▒▓▒ ▒ ░ ▒▒   ▓▒█░ ░▒   ▒  ▒▒   ▓▒█░░ ▒░   ▒ ▒ ]],
        [[ ░       ░▒ ░ ▒░  ▒   ▒▒ ░░ ░░   ░ ▒░  ░  ▒     ░ ▒ ▒░  ▒ ░░ ░▒  ░ ░ ░ ░  ░   ░ ░▒  ░ ░  ▒   ▒▒ ░  ░   ░   ▒   ▒▒ ░░ ░░   ░ ▒░]],
        [[ ░ ░     ░░   ░   ░   ▒      ░   ░ ░ ░        ░ ░ ░ ▒   ▒ ░░  ░  ░     ░      ░  ░  ░    ░   ▒   ░ ░   ░   ░   ▒      ░   ░ ░ ]],
        [[          ░           ░  ░         ░ ░ ░          ░ ░   ░        ░     ░  ░         ░        ░  ░      ░       ░  ░         ░ ]],
        [[                                     ░                                                                                        ]],
      }
  
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("SPC f f", "  Find file", ":Telescope find_files <CR>"),
        dashboard.button("SPC f o", "  Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("SPC f g", "  Find word", ":Telescope live_grep <CR>"),
        dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
        dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
      }
  
      local function footer()
        local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
        return datetime
      end
      dashboard.section.footer.val = footer()
      dashboard.section.footer.opts.hl = "Constant"
  
      dashboard.config.layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }
  
      alpha.setup(dashboard.config)
  
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local should_skip = false
          if vim.fn.argc() > 0 or vim.fn.line2byte('$') ~= -1 or not vim.o.modifiable then
            should_skip = true
          else
            for _, arg in pairs(vim.v.argv) do
              if arg == '-b' or arg == '-c' or vim.startswith(arg, '+') or arg == '-S' then
                should_skip = true
                break
              end
            end
          end
          if not should_skip then require('alpha').start(true) end
        end,
      })
    end
  }