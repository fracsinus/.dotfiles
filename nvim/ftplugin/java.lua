vim.o.shiftwidth = 4

local default = require("configs.lsp._default")
local util = require("lspconfig/util")

local home = os.getenv("HOME")

local root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew"})
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = util.path.join(home, ".cache", "jdtls", "workspace-" .. project_name)

local fork_root = util.path.join(home, ".local", "eclipse.jdt.ls")

local jdtls_root = util.path.join(fork_root, "org.eclipse.jdt.ls.product", "target", "repository")
local lombok_path = util.path.join(fork_root, "lombok.jar")

-- local mason_registry = require("mason-registry")
-- local mason_jdtls = mason_registry.get_package("jdtls")

local config = {
  cmd = {
    util.path.join(jdtls_root, "bin", "jdtls"),
    -- "/Users/user/.local/share/nvim/mason/packages/jdtls/jdtls",
    "--jvm-arg=-Dlog.protocol=true",
    "--jvm-arg=-Dlog.level=ALL",
    "--jvm-arg=-Xmx1g",
    "--jvm-arg=-javaagent:" .. lombok_path,
    -- "/Users/user/.local/share/nvim/mason/packages/jdtls/lombok.jar",
    "--jvm-arg=-Djava.autobuild=false",
    "-configuration",
    util.path.join(jdtls_root, "config_mac_arm"),
    -- "/Users/user/.local/share/nvim/mason/packages/jdtls/config_mac_arm",
    "-data",
    workspace_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {
      autobuild = { enabled = false },
      -- format = {
      --   settings = {
      --     url = util.path.join(root_dir, ".vscode", "java-formatter.xml"),
      --     profile = "JavaConventions",
      --   },
      -- },
      -- configuration = {
      --   updateBuildConfiguration = 'disabled',
      -- },
      -- import = {
      --   maven = { enabled = false },
      --   gradle = { enabled = false },
      -- },
      -- project = {
      --   resourceFilters = {},
      -- },
      references = {
        -- includeClassFiles = true,
        -- includeDecompiledSources = false,
      },
      search = { scope = "main" },
    },
  },
  init_options = {
    -- bundles = vim.fn.glob(util.path.join(home, ".local", "vscode-java-test", "server", "*.jar"), false, true),
  },
  capabilities = default.capabilities,
  on_attach = default.on_attach_lsp,
}

require("jdtls").start_or_attach(config)
