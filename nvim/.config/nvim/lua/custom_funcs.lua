---------------------------------------------------------------------------------
-- [[ Terminal functions ]]
---------------------------------------------------------------------------------
function OpenTerminalNewProcess()
  local cwd = vim.fn.getcwd()
  local terminal_cmd = "st -e fish -c 'cd " .. cwd .. "; fish' &"

  os.execute(terminal_cmd)
end

vim.api.nvim_set_keymap('n', '<leader>t', ':lua OpenTerminalNewProcess()<CR>', { noremap = true, silent = true })

---------------------------------------------------------------------------------
-- [[ Xmake run functions ]]
---------------------------------------------------------------------------------
function Runxmake(opts)
    local args = opts.args

    if #args == 0 then
        vim.cmd('!echo "building: " && xmake && echo "running: " && xmake r')  -- Run without arguments
    else
        if type(args) == "string" then
            args = vim.split(args, "%s+")  -- Split the string into a table based on spaces
        end

        vim.cmd('!xmake ' .. table.concat(args, ' '))  -- Run with arguments
    end
end
-- '*' allows any number of arguments
vim.api.nvim_create_user_command('Make', Runxmake, {nargs = '*'})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "xmake.lua",  -- This will match files named 'xmake.lua'
    callback = function()
        -- Run the command asynchronously
        vim.fn.jobstart("xmake_lsp", {
            on_exit = function(_, code)
                if code ~= 0 then
                    print("Error running xmake_lsp: " .. code)
                end
            end
        })
    end
})
