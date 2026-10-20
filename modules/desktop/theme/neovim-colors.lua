-- Noctalia uses XDG_CACHE_HOME, whereas Neovim appends /nvim to stdpath("cache").
local palette_path = (vim.env.XDG_CACHE_HOME or (vim.env.HOME .. "/.cache"))
  .. "/noctalia/neovim-palette.lua"

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local previous
      local function apply()
        local file = io.open(palette_path, "r")
        local contents = file and file:read("*a") or ""
        if file then file:close() end
        if contents == previous then return end
        local ok, palette = pcall(dofile, palette_path)
        if not ok or type(palette) ~= "table" then
          palette = {}
        end
        require("tokyonight").setup({
          transparent = true,
          on_colors = function(colors)
            for key, value in pairs(palette) do colors[key] = value end
            colors.bg_float = colors.bg_dark
            colors.bg_popup = colors.bg_dark
            colors.bg_sidebar = colors.bg_dark
            colors.bg_statusline = colors.bg_dark
            colors.blue0 = colors.blue
            colors.blue1 = colors.cyan
            colors.blue2 = colors.cyan
            colors.blue5 = colors.cyan
            colors.blue6 = colors.cyan
            colors.blue7 = colors.blue
            colors.green1 = colors.green
            colors.green2 = colors.green
            colors.magenta2 = colors.magenta
            colors.purple = colors.magenta
            colors.teal = colors.cyan
            colors.dark3 = colors.comment
            colors.dark5 = colors.fg_dark
            colors.error = colors.red
            colors.warning = colors.yellow
            colors.info = colors.blue
            colors.hint = colors.cyan
          end,
        })
        vim.cmd.colorscheme("tokyonight")
        previous = contents
        local loaded, lualine = pcall(require, "lualine")
        if loaded then lualine.refresh() end
      end
      apply()
      vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
        group = vim.api.nvim_create_augroup("NoctaliaPalette", { clear = true }),
        callback = apply,
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { options = { theme = "auto" } },
  },
}
