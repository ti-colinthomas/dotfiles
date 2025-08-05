return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signcolumn = true,
            word_diff = true
        })
    end,
    event = "VeryLazy"
}

