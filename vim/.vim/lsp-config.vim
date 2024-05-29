vim9script

var lspServers = [
    {
        name: 'golang',
        filetype: ['go', 'gomod'],
        path: '/home/jason/go/bin/gopls',
        args: ['serve'],
        syncInit: v:true
    },
    {
        name: 'zig',
        filetype: ['zig', 'zon'],
        path: '/usr/local/bin/zls',
        syncInit: v:true
    }
]
autocmd User LspSetup call LspAddServer(lspServers)

nnoremap <leader>lf <Cmd>LspFormat<CR>
nnoremap <leader>la <Cmd>LspCodeAction<CR>
nnoremap <leader>lr <Cmd>LspRename<CR>
nnoremap <leader>ld <Cmd>LspDiag first<CR>
nnoremap K :LspHover<CR>
