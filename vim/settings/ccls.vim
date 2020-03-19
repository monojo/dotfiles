"====== Using coc as ccls's front end ======
" bases
nn <silent> xb :call CocLocations('ccls','$ccls/inheritance')<cr>
"" bases of up to 3 levels
nn <silent> xB :call CocLocations('ccls','$ccls/inheritance',{'levels':3})<cr>
"" derived
nn <silent> xd :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>
"" derived of up to 3 levels
nn <silent> xD :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':3})<cr>

"" caller
nn <silent> xc :call CocLocations('ccls','$ccls/call')<cr>
" callee
nn <silent> xC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>

"" $ccls/member
"" member variables / variables in a namespace
nn <silent> xm :call CocLocations('ccls','$ccls/member')<cr>
"" member functions / functions in a namespace
nn <silent> xf :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>
"" nested classes / types in a namespace
nn <silent> xs :call CocLocations('ccls','$ccls/member',{'kind':2})<cr>
"" Get from ccls emacs' setting
"" reference read
nn <silent> xr :call CocLocations('ccls','textDocument/references',{'role':8})<cr>
"" reference write
nn <silent> xw :call CocLocations('ccls','textDocument/references',{'role':16})<cr>
"" reference macro 
nn <silent> xM :call CocLocations('ccls','textDocument/references',{'role':64})<cr>

nmap <silent> xt <Plug>(coc-type-definition)<cr>
nn <silent> xv :call CocLocations('ccls','$ccls/vars')<cr>
nn <silent> xV :call CocLocations('ccls','$ccls/vars',{'kind':1})<cr>

"====== ccls call hierarchy ======
let g:ccls_position = 'right'
let g:ccls_levels = 5

nn xx x
