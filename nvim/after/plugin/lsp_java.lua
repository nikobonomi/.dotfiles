local mason_env = vim.env.MASON
local mason_path = vim.fn.stdpath("data") .. "/mason"
local mason_home = (mason_env or mason_path) .. "/packages"

local java_debug = mason_home .. "/java-debug-adapter"
local java_test = mason_home .. "/java-test"

local java_debug_bundle = vim.split(
    vim.fn.glob(java_debug .. '/extension/server/com.microsoft.java.debug.plugin-*.jar'),
    '\n'
)

local java_test_bundle = vim.split(
    vim.fn.glob(java_test .. '/extension/server/*.jar'),
    '\n'
)

local bundles = {}
vim.list_extend(bundles, java_debug_bundle)
vim.list_extend(bundles, java_test_bundle)

vim.lsp.config("jdtls", {
  init_options = {
    bundles = bundles
  }
})
vim.lsp.enable('jdtls')
