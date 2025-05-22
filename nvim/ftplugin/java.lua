local default = require("configs.lsp._default")
local util = require("lspconfig/util")

local home = os.getenv("HOME")

local root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew"})
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = util.path.join(home, ".cache", "jdtls", "workspace-" .. project_name)

local fork_root = util.path.join(home, ".local", "eclipse.jdt.ls")

local jdtls_root = util.path.join(fork_root, "org.eclipse.jdt.ls.product", "target", "repository")
local lombok_path = util.path.join(fork_root, "lombok.jar")

local config = {
  cmd = {
    util.path.join(jdtls_root, "bin", "jdtls"),
    "--jvm-arg=-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "--jvm-arg=-Dosgi.bundles.defaultStartLevel=4",
    "--jvm-arg=-Declipse.product=org.eclipse.jdt.ls.core.product",
    "--jvm-arg=-Dlog.protocol=true",
    "--jvm-arg=-Dlog.level=ALL",
    "--jvm-arg=-Xmx1g",
    "--jvm-arg=-javaagent:" .. lombok_path,
    "-configuration",
    util.path.join(jdtls_root, "config_mac_arm"),
    "-data",
    workspace_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {
      autobuild = { enabled = false },
      maven = { enabled = false, offline = { enabled = true } },
      gradle = { enabled = false, offline = { enabled = true } },
      references = {
        includeDecompiledSources = false,
      },
      search = { scope = "main" },
    },
  },
  capabilities = default.capabilities,
  on_attach = default.on_attach_lsp,
}

require("jdtls").start_or_attach(config)
