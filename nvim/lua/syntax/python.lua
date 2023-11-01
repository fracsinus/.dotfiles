local packer = require("packer")

-- manually setting python executable path to make startup faster
vim.g["python3_host_prog"] = '/usr/bin/python'

-- PEP8 compliant indent
packer.use('Vimjas/vim-python-pep8-indent')
---- indent multiline string
vim.g["python_pep8_indent_multiline_string"] = -2

