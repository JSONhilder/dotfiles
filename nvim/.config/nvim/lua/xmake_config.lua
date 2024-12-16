---------------------------------------------------------------------------------
-- [[ Xmake run function ]]
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
