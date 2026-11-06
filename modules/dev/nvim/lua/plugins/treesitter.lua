return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',

	config = function()
		local ts = require('nvim-treesitter')
		ts.setup()

		local function start(buf, lang)
			return pcall(vim.treesitter.start, buf, lang)
		end

		vim.api.nvim_create_autocmd('FileType', {
			group = vim.api.nvim_create_augroup('my.treesitter', {}),
			callback = function(args)
				local buf = args.buf
				local lang = vim.treesitter.language.get_lang(args.match)
				if not lang or start(buf, lang) then
					return
				end
				if not vim.tbl_contains(ts.get_available(), lang) then
					return
				end
				ts.install(lang):await(function(err)
					if err then
						return
					end
					vim.schedule(function()
						if vim.api.nvim_buf_is_valid(buf) then
							start(buf, lang)
						end
					end)
				end)
			end,
		})
	end,
}
