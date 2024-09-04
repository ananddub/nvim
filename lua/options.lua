require "nvchad.options"


-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
local opt = vim.opt

opt.shiftwidth = 4
opt.tabstop = 4
opt.clipboard = "unnamedplus"
opt.expandtab = true
opt.smartindent = true
opt.smartcase = true
opt.ignorecase = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes"
-- opt.number = true
-- opt.relativenumber = true
vim.keymap.set("n", "<C-_>", function()
    require("Comment.api").toggle.linewise.current()
end, { noremap = true, silent = true })
