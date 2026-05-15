return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      require("jdtls").start_or_attach({
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls" },
        root_dir = vim.fs.dirname(
          vim.fs.find({ "gradlew", "mvnw", "pom.xml", ".git" }, { upward = true })[1]
        ),
      })
    end,
  },
}