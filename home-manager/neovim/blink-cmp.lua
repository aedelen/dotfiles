---@module 'blink.cmp'
---@type blink.cmp.Config
local blink_config = {
	keymap = {
		preset = "default",
		["<C-k>"] = {},
		-- can't figure out what show_signature does so I'm not sure it works
		["<C-,>"] = { "show_signature", "hide_signature", "fallback" },
	},
	appearance = {
		-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
	},
	-- (Default) Only show the documentation popup when manually triggered
	completion = { documentation = { auto_show = false } },

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
}
require("blink-cmp").setup(blink_config)
