return {
	"mfussenegger/nvim-jdtls",
  config = function ()
    
			vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "[G]oto [T]ype definition" })
  end
}
