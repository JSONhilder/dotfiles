vim9script

var lspServers = [
    {
        name: 'c3',
        filetype: ['c3', 'c3i'],
        path: '/usr/local/bin/c3lsp',
        args: [
			'--c3c-path',
			'/usr/local/bin/c3c',
			'--stdlib-path',  
			'/home/jason/github/c3_stuff/c3_lang/c3c/lib/std',
			'--diagnostics-delay',
			'1000',
		]
    },
    {
        name: 'golang',
        filetype: ['go', 'gomod'],
        path: '/home/jason/go/bin/gopls',
        args: ['serve'],
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
}

autocmd User LspSetup call LspOptionsSet(options)
