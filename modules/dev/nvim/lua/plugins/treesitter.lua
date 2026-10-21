return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',

  config = function()
    require('nvim-treesitter').setup()

    require('nvim-treesitter').install({
      'lua',
      'c',
    })

    vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'c', 'lua' },
	callback = function() 
	    vim.treesitter.start() 
	end,
    })
  end,
}
