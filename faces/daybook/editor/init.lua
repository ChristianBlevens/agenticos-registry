-- pyright from the focused toolbelt, through raigolmid's glue (raigolmi.lua).
local raigolmi = require('raigolmi')
raigolmi.setup({
  pyright = {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    settings = { python = { pythonPath = '/usr/local/bin/python3' } },
  },
})

-- A file Claude shows (show_file) is written on the page, which brings the editor's thread
-- up: the page is what places windows (desktop/daybook.py, hint "showfile").
local show = raigolmi.show
raigolmi.show = function(request)
  show(request)
  local dir = (os.getenv('XDG_RUNTIME_DIR') or '/tmp') .. '/daybook'
  vim.fn.mkdir(dir, 'p')
  vim.fn.writefile({ vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':~') }, dir .. '/showfile.new')
  vim.uv.fs_rename(dir .. '/showfile.new', dir .. '/showfile')
end

-- Paper, like the rest of the face: the terminal's palette, not nvim's own colours.
vim.o.termguicolors = false
vim.o.background = 'light'
vim.o.number = true
vim.o.signcolumn = 'yes'
vim.o.laststatus = 3
-- The page shows a thread by its title: the file, not "foot".
vim.o.title = true
vim.o.titlestring = "editor%{expand('%:t') ==# '' ? '' : ' · ' . expand('%:t')}"

-- The mouse is the terminal's, so selecting copies and right-click pastes (/guide/faces.md).
vim.o.mouse = ''
