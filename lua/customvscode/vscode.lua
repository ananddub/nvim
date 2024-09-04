-- Basic keymaps
vim.keymap.set('n', '<leader>e', ':Ex<CR>', { noremap = true, silent = true })
if vim.g.vscode then
    vim.keymap.set('n', '<C-b>', function()
        vim.fn.VSCodeNotify('workbench.view.explorer')
    end, { silent = true })

    -- Keybinding for searching in files
    vim.keymap.set('n', '<C-f>', function()
        vim.fn.VSCodeNotify('workbench.action.findInFiles')
    end, { silent = true })

    -- Keybinding for toggling terminal
    vim.keymap.set('n', '<C-`>', function()
        vim.fn.VSCodeNotify('workbench.action.terminal.toggleTerminal')
    end, { silent = true })

    -- Refactoring action
    vim.keymap.set({ "n", "x" }, "<leader>r", function()
        vim.fn.VSCodeNotify('editor.action.refactor')
    end)
end
