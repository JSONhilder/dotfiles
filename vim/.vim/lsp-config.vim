vim9script

# var lspServers = [
#     {
#         name: 'clangd',
#         filetype: ['c', 'cpp'],
#         path: '/usr/bin/clangd',
#         args: ['--background-index']
#     },
#     {
#         name: 'golang',
#         filetype: ['go', 'gomod'],
#         path: '/home/jason/go/bin/gopls',
#         args: ['serve'],
#         syncInit: v:true
#     }
# ]
# autocmd User LspSetup call LspAddServer(lspServers)

nnoremap <leader>lf <Cmd>LspFormat<CR>
nnoremap <leader>la <Cmd>LspCodeAction<CR>
nnoremap <leader>lr <Cmd>LspRename<CR>
nnoremap <leader>ld <Cmd>LspDiag first<CR>
nnoremap K :LspHover<CR>
nnoremap gd :LspGotoDefinition<CR>
nnoremap gD :LspGotoDeclaration<CR>
