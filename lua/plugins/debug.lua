-- lua/plugins/debug.lua
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Setup UI
    dapui.setup()
    require('nvim-dap-virtual-text').setup()

    -- Auto open/close UI
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -- Keymaps
    vim.keymap.set('n', '<F5>', dap.continue)
    vim.keymap.set('n', '<F10>', dap.step_over)
    vim.keymap.set('n', '<F11>', dap.step_into)
    vim.keymap.set('n', '<F12>', dap.step_out)
    vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint)
    vim.keymap.set('n', '<Leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end)
    vim.keymap.set('n', '<Leader>dr', dap.repl.open)

    ------------------------------------
    -- C / C++
    ------------------------------------
    dap.adapters.cppdbg = {
      id = 'cppdbg',
      type = 'executable',
      command = '/path/to/OpenDebugAD7',
    }
    dap.configurations.cpp = {
      {
        name = 'Launch file',
        type = 'cppdbg',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
      },
    }
    dap.configurations.c = dap.configurations.cpp

    ------------------------------------
    -- Python
    ------------------------------------
    dap.adapters.python = {
      type = 'executable',
      command = '/usr/bin/python3',
      args = { '-m', 'debugpy.adapter' },
    }
    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        pythonPath = function()
          return '/usr/bin/python3'
        end,
      },
    }

    ------------------------------------
    -- Java
    ------------------------------------
    dap.adapters.java = function(callback)
      callback { type = 'server', host = '127.0.0.1', port = 5005 }
    end
    dap.configurations.java = {
      { type = 'java', request = 'attach', name = 'Attach to JVM', hostName = '127.0.0.1', port = 5005 },
    }

    ------------------------------------
    -- C#
    ------------------------------------
    dap.adapters.coreclr = {
      type = 'executable',
      command = '/path/to/netcoredbg',
      args = { '--interpreter=vscode' },
    }
    dap.configurations.cs = {
      {
        type = 'coreclr',
        name = 'Launch - netcoredbg',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
      },
    }

    ------------------------------------
    -- JavaScript / Node.js
    ------------------------------------
    dap.adapters.node2 = {
      type = 'executable',
      command = 'node',
      args = { '/path/to/vscode-node-debug2/out/src/nodeDebug.js' },
    }
    dap.configurations.javascript = {
      {
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
      },
    }

    ------------------------------------
    -- Lua
    ------------------------------------
    dap.adapters.nlua = function(callback)
      callback { type = 'server', host = '127.0.0.1', port = 8086 }
    end
    dap.configurations.lua = {
      {
        type = 'nlua',
        request = 'attach',
        name = 'Attach to running Neovim instance',
      },
    }
  end,
}
