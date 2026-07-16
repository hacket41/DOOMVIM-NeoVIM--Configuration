-- Auto hot-reload Flutter on file save
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.dart',
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[buf].buftype == 'terminal' then
        local job_id = vim.b[buf].terminal_job_id
        if job_id and vim.fn.jobwait({ job_id }, 0)[1] == -1 then
          vim.fn.chansend(job_id, 'r')
          break
        end
      end
    end
  end,
  desc = 'Flutter hot reload on save',
})
