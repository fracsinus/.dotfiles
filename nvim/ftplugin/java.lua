local default = require("configs.lsp._default")
local util = require("lspconfig/util")

-- local root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}) ,
local root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew"})
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = os.getenv("HOME") .. "/.cache/jdtls/workspace-" .. project_name
local lombok_path = "/Users/user/.gradle/caches/modules-2/files-2.1/org.projectlombok/lombok/1.18.38/57f8f5e02e92a30fd21b80cbd426a4172b5f8e29/lombok-1.18.38.jar"


local config = {
  -- cmd = { vim.fn.exepath("jdtls") },
  cmd = {
    --
    -- 				-- 💀
    "java", -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    -- "-javaagent:" .. lombok_path,
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    -- 💀
    "-jar",
    "/opt/homebrew/Cellar/jdtls/1.46.1/libexec/plugins/org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar",
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version

    -- 💀
    "-configuration",
    "/opt/homebrew/Cellar/jdtls/1.46.1/libexec/config_mac",
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.

    -- 💀
    -- See `data directory configuration` section in the README
    "-data",
    workspace_dir,
  },
  root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}) ,
  on_attach = default.on_attach_lsp,
  capabilities = default.capabilities,
  -- settings = {
  --   -- ["java.jdt.ls.lombokSupport.enabled"] = true,
  --   -- ["java.import.gradle.enabled"] = false,
  --   java = {
  --     configuration = {
  --       runtimes = {
  --         {
  --           name = "JavaSE-21",
  --           path = io.popen("/usr/libexec/java_home -v21"):read()
  --         },
  --       },
  --     },
  --     jdt = {
  --       ls = {
  --         lombokSupport = {
  --           enabled = false,
  --         },
  --       },
  --     },
  --     import = {
  --       gradle = {
  --         enabled = true,
  --         annotationProcessing = {
  --           enabled = true,
  --         },
  --         wrapper = true,
  --       },
  --     },
  --   },
  -- },
}

require("jdtls").start_or_attach(config)
