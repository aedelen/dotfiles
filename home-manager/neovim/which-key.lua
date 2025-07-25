local wk = require("which-key")
wk.setup()

wk.add({
	{ "<leader>c", group = "[C]ode" },
	{ "<leader>d", group = "[D]ocument" },
	{ "<leader>r", group = "[R]ename" },
	{ "<leader>s", group = "[S]earch" },
	{ "<leader>f", group = "[F]ind" },
	{ "<leader>w", group = "[W]orkspace" },
	{ "<leader>t", group = "[T]oggle" },
	{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
})
