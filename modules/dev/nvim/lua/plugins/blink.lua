return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = { "rafamadriz/friendly-snippets" },

  opts = {
    keymap = { preset = "enter" },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      menu = { auto_show_delay_ms = 150 },
      list = { selection = { preselect = false, auto_insert = false } },
      documentation = { auto_show = false },
    },
    signature = { enabled = true },
    sources = {
      default = { "lsp", "path", "snippets" },
      min_keyword_length = 2,
    },
  },
}
