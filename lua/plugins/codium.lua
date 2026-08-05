return {
  'Exafunction/windsurf.nvim',
  event = 'InsertEnter',
  config = function()
    require('codeium').setup {
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        manual = false,
        default_filetype_enabled = true,
        idle_delay = 75,
        virtual_text_priority = 65535,
        map_keys = true,
        key_bindings = {
          accept = '<C-g>',
          next = '<M-]>',
          prev = '<M-[>',
        },
      },
    }
  end,
}
