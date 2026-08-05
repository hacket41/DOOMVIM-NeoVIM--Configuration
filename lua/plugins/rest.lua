return {
  {
    'rest-nvim/rest.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      require('rest-nvim').setup {
        result_split_horizontal = false,
        result_split_in_place = false,
        skip_ssl_verification = false,
        encode_url = true,
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result_format = 'json',
      }
    end,
  },
}
