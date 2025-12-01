local ws_root = "/home/adam/Documents/syncthing/Adam's Stuff/ObsidianVaults/"

require("obsidian").setup({
	ui = { enable = false },
	legacy_commands = false,

	-- A list of workspace names, paths, and configuration overrides.
	-- If you use the Obsidian app, the 'path' of a workspace should generally be
	-- your vault root (where the `.obsidian` folder is located).
	-- When obsidian.nvim is loaded by your plugin manager, it will automatically set
	-- the workspace to the first workspace in the list whose `path` is a parent of the
	-- current markdown file being edited.
	workspaces = {
		{
			name = "personalNotes",
			path = ws_root .. "PersonalNotes",
		},
		{
			name = "Numenera",
			path = ws_root .. "Numenera",
		}
	},

	notes_subdir = "Notes",

	-- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
	-- levels defined by "vim.log.levels.\*".
	log_level = vim.log.levels.INFO,

	-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
	completion = {
		blink = true,
		min_chars = 2,
		create_new = true,
	},
	-- Where to put new notes. Valid options are
	-- _ "current_dir" - put new notes in same directory as the current buffer.
	-- _ "notes_subdir" - put new notes in the default notes subdirectory.
	new_notes_location = "notes_subdir",

	-- Optional, customize how note IDs are generated given an optional title.
	---@param title string|?
	---@return string
	note_id_func = function(title)
		-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
		-- In this case a note with the title 'My new note' will be given an ID that looks
		-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'.
		-- You may have as many periods in the note ID as you'd like—the ".md" will be added automatically
		local suffix = ""
		if title ~= nil then
			-- If title is given, transform it into valid file name.
			suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		else
			-- If title is nil, just add 4 random uppercase letters to the suffix.
			for _ = 1, 4 do
				suffix = suffix .. string.char(math.random(65, 90))
			end
		end
		return tostring(os.time()) .. "-" .. suffix
	end,

	picker = {
		-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
		name = "telescope.nvim",
		-- Optional, configure key mappings for the picker. These are the defaults.
		-- Not all pickers support all mappings.
		note_mappings = {
			-- Create a new note from your query.
			new = "<C-x>",
			-- Insert a link to the selected note.
			insert_link = "<C-l>",
		},
		tag_mappings = {
			-- Add tag(s) to current note.
			tag_note = "<C-x>",
			-- Insert a tag at the current location.
			insert_tag = "<C-l>",
		},
	},
	daily_notes = {
		-- Optional, if you keep daily notes in a separate directory.
		folder = "Daily notes",
		-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
		template = nil,
		-- Optional, if you want `Obsidian yesterday` to return the last work day or `Obsidian tomorrow` to return the next work day.
		workdays_only = false,
	},
})

-- Setup keymaps
require("which-key").add({ { "<leader>o", group = "[O]bsidian" } })
vim.keymap.set("n", "<leader>og", "<cmd>Obsidian search<cr>", { desc = "[O]bsidian [G]rep" })
vim.keymap.set("n", "<leader>of", "<cmd>Obsidian quick_switch<cr>", { desc = "[O]bsidian Quick [F]ind" })
vim.keymap.set("n", "<leader>ow", "<cmd>Obsidian workspace<cr>", { desc = "[O]bsidian Switch [W]orkspace" })
vim.keymap.set("n", "<leader>od", "<cmd>Obsidian dailies<cr>", { desc = "[O]bsidian Search [D]ailies" })
vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian today<cr>", { desc = "[O]bsidian Open [T]oday" })
vim.keymap.set("n", "<leader>oT", "<cmd>Obsidian tomorrow<cr>", { desc = "[O]bsidian Open [T]omorrow" })
vim.keymap.set("n", "<leader>op", "<cmd>Obsidian yesterday<cr>", { desc = "[O]bsidian [P]revious Day" })
vim.keymap.set("n", "<leader>oN", "<cmd>Obsidian new<cr>", { desc = "[O]bsidian [N]ew Note" })
vim.keymap.set("n", "<leader>on", "<cmd>Obsidian new<cr><cr>", { desc = "[O]bsidian Quick [n]ew Note" })
vim.keymap.set("n", "<leader>oq", "<cmd>Obsidian <cr>", { desc = "[O]bsidian [Q]uick Menu" })
