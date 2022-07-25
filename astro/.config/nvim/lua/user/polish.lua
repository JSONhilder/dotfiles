return function()
    -- This function is run last good place to configure mappings and vim options
    -- Set key bindings
    vim.keymap.set("n", "<C-s>", ":w!<CR>")

    vim.keymap.set("n", "<leader><leader>", ":Telescope find_files hidden=true theme=ivy<cr>")
    vim.keymap.set("n", "<leader>i", ":Telescope buffers theme=ivy<cr>")
    -- switch to previous buffer
    vim.keymap.set("n", "<leader>;", ":b#<cr>")
    vim.keymap.set("n", "<C-j>", ":ToggleTerm size=80 direction=vertical<cr>")

    -- quality of life stuff
    vim.keymap.set("n", "Y", "y$")
    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
    vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
    vim.keymap.set("v", "<Tab>", ">gv")
    vim.keymap.set("v", "<S-Tab>", "<gv")

    -- compile project in new terminal
    Terminal  = require('toggleterm.terminal').Terminal
    Cp = Terminal:new({ cmd = "bash ~/.dotfiles/scripts/compile.sh", direction="float", float_opts = { border = "single" }, hidden = true, close_on_exit = false })
    function Compile_project()
      Cp:toggle()
    end
    vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>lua Compile_project()<CR>", {noremap = true, silent = true})

    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = "plugins.lua",
      command = "source <afile> | PackerSync",
    })

    vim.cmd([[
      autocmd BufWritePre * %s/\s\+$//e
      autocmd BufWritePre * %s/\n\+\%$//e
    ]])

    -- status line
    dofile("/home/jason/.dotfiles/astro/.config/nvim/lua/user/statusline.lua")

    vim.api.nvim_exec([[
      augroup Statusline
      au!
      au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
      au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
      au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
      augroup END
      hi rainbowcol1 guifg = #bf7330
      highlight Normal guibg=none
    ]], false)
end
