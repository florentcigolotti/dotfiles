require("nnn").setup({
  picker = {
    style = {
      border = "rounded",
      width = 0.4, -- width in percentage of the viewport
      height = 0.8, -- height in percentage of the viewport
      xoffset = 0.9, -- xoffset in percentage
      yoffset = 0.5, -- yoffset in percentage
    },
  },
  replace_netrw = "picker",
})

local utils = require("florentc.utils")
utils.map("n", "<leader>fb", "<cmd>NnnPicker<CR>")
