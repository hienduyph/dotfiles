-- compose setup start
require'compe'.setup {
  source = {
    path = true,
    nvim_lsp = true,
    luasnip = false,
    buffer = false,
    calc = false,
    nvim_lua = false,
    vsnip = false,
    ultisnips = true,
  },
}

vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true })


-- compose setup done
