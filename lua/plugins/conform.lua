-- ~/.config/nvim/lua/plugins/conform.lua
return {
  {
    "stevearc/conform.nvim",
    lazy = false, -- load immediately
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "", -- all modes
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        html = { "djlint" },
        go = { "gofmt", "goimports" },
        c = { "clang_format" },
        cpp = { "clang_format" },
      },
      formatters = {
        clang_format = {
          prepend_args = { "--style=file", "--fallback-style=LLVM" },
        },
        shfmt = {
          prepend_args = { "-i", "4" },
        },
      },
    },
  },
}
