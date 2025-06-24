vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left toggle<CR>", {desc = "Open file menu"})
vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {desc = "[B]uffer [F]loat"})

require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
		}
	}
})

