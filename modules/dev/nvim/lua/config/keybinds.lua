vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("n", "<leader>?", function()
    vim.cmd.vsplit(vim.fn.stdpath("config") .. "/cheatsheet.md")
end, { desc = "Cheatsheet" })
