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
        name: 'odin',
        filetype: ['odin'],
        path: '/home/jason/.local/bin/ols',
        syncInit: v:true
    },
    {
        name: 'clang',
        filetype: ['c', 'h'],
        path: '/usr/bin/clangd',
        syncInit: v:true
    }
]


autocmd User LspSetup call LspAddServer(lspServers)

nnoremap <leader>lf <Cmd>LspFormat<CR>
nnoremap <leader>la <Cmd>LspCodeAction<CR>
nnoremap <leader>lr <Cmd>LspRename<CR>
nnoremap <leader>ld <Cmd>LspDiag first<CR>
nnoremap K :LspHover<CR>
nnoremap gd :LspGotoDefinition<CR>
nnoremap gD :LspGotoDeclaration<CR>

var options = {
    autoComplete: v:true,
	echoSignature: v:true,
	showDiagOnStatusLine: v:true,
	autoPopulateDiags: v:true,
	outlineOnRight: v:true
}

autocmd User LspSetup call LspOptionsSet(options)
