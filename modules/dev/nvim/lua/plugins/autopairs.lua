return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",

  opts = {
    check_ts = true,
    ignored_next_char = "[%w%.]",
  },
}
