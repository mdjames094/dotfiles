" add the proper PEP 8 indentation
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix

setlocal foldmethod=indent
setlocal foldlevel=99

" python with virtualenv support
" make VIM and YouCompleteMe aware of virtualenv
if has('python')
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
endif


" make code look pretty
let python_highlight_all=1


"map <F8> <Esc>:w<CR>:!clear;python %<CR>


