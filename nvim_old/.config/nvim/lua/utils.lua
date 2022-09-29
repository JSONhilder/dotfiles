-- hide line numbers , statusline in specific buffers!
vim.api.nvim_exec([[
   au TermOpen term://* setlocal nonumber laststatus=2
   au TermClose term://* setlocal laststatus=2
]], false)

--we can load shada now
vim.opt.shadafile = ""
