return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    -- rustaceanvim sets up rust_analyzer itself,
    -- so don't call vim.lsp.enable("rust_analyzer")
    -- Just install rust_analyzer via :MasonInstall rust_analyzer
  },
}