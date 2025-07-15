require("telescope").setup({
	extensions = {
		["ui-select"]= {
			require("telescope.themes").get_dropdown({}),
		},
	},
	pickers = {
		live_grep = {
			additional_args = function(opts)
				return {"--hidden", "--glob=!**/.git/*"}
			end
		},
	},
})


local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>fp", builtin.git_files, { desc = "[F]ind [P]roject" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind live [G]rep" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, {desc = "[F]ind [F]iles"})


require("telescope").load_extension("ui-select")
require('telescope').load_extension('fzf')
