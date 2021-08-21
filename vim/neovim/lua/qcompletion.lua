-- compose setup start
require'compe'.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    path = true,
    nvim_lsp = true,
    ultisnips = true,
    buffer = { kind = "﬘", true },
    calc = false,
    nvim_lua = false,
    vsnip = false,
    luasnip = false,
  },
}

vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true })

-- compose setup done
