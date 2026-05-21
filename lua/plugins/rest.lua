return {
  'rest-nvim/rest.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('rest-nvim').setup {
      result_split_horizontal = false, -- open results in vertical split
      result_split_in_place = false, -- don’t open in place
      skip_ssl_verification = false,
      encode_url = true,
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result_format = 'json', -- pretty print JSON
    }
  end,
}
