require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
			hide_by_name = { ".git" },
		},
	},
})

vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left toggle<CR>", { desc = "Open file menu" })
