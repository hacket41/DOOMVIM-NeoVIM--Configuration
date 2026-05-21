return {
  'mfussenegger/nvim-jdtls',
  ft = { 'java' }, -- load only for Java files
  config = function()
    local jdtls = require 'jdtls'
    local home = vim.fn.expand '~'

    -- Determine project root, fallback to cwd
    local root_dir = require('jdtls.setup').find_root { '.git', 'pom.xml', 'build.gradle' }
    if not root_dir or root_dir == '' then
      root_dir = vim.fn.getcwd()
      vim.notify('JDTLS: Using fallback root_dir = ' .. root_dir, vim.log.levels.INFO)
    end

    -- Workspace folder
    local workspace_dir = home .. '/.local/share/eclipse/workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')
    vim.fn.mkdir(workspace_dir, 'p')

    -- Path to JDTLS
    local jdtls_path = home .. '/.local/share/jdtls' -- adjust if installed elsewhere
    local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
    local config_path = jdtls_path .. '/config_linux' -- use config_mac / config_win if needed

    -- LSP configuration
    local config = {
      cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '-jar',
        launcher_jar,
        '-configuration',
        config_path,
        '-data',
        workspace_dir,
      },
      root_dir = root_dir,
      settings = {
        java = {
          signatureHelp = { enabled = true },
          contentProvider = { preferred = 'fernflower' },
          completion = { favoriteStaticMembers = {}, importOrder = {} },
          sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
          codeGeneration = {
            toString = { template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}' },
          },
        },
      },
      init_options = { bundles = {} },
    }

    -- Attach or start JDTLS
    jdtls.start_or_attach(config)
  end,
}
